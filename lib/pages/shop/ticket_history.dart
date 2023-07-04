import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/tikethistory.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/detail_history_tiket.dart';
import 'package:persedikab_app/widget/card_trxTiketHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TicketHistoryTrx extends StatefulWidget {
  const TicketHistoryTrx({Key? key}) : super(key: key);

  @override
  State<TicketHistoryTrx> createState() => _TicketHistoryTrxState();
}

class _TicketHistoryTrxState extends State<TicketHistoryTrx> {
  List<Data> tiket = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var idUser = pref.getString("idUser");
      var jsonResponse =
          await http.get(Uri.parse(BaseUrl.historyTiket + idUser.toString()));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        tiket = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
        cekTransaksi();
      }
    } catch (e) {
      print(e);
    }
    return tiket;
  }

  void cekTransaksi() async {
    for (var i = 0; i < tiket.length; i++) {
      var orderId = tiket[i].orderId;
      await http.get(Uri.parse(BaseUrl.cekTransaksiTiket + orderId));
    }
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listTiket) {
      setState(() => tiket = _listTiket);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<List<Data>>(
            future: _fetchData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
              if (snapshot.hasData) {
                tiket = snapshot.data!;
                return Container(
                  height: double.infinity,
                  // margin: EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                      itemCount: tiket.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var _data = tiket[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailHistoryTiket(history: _data)));
                          },
                          child: CardHistoryTiket(history: _data),
                        );
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
        ));
  }
}
