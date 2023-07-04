import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/models/transaction_detail.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/detail_history.dart';
import 'package:persedikab_app/widget/card_HistoryTrx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  List<Data> listHistory = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var idUser = pref.getString("idUser");
      var jsonResponse = await http
          .get(Uri.parse(BaseUrl.historyTransaksi + idUser.toString()));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listHistory = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
        cekTransaksi();
      }
    } catch (e) {
      print(e);
    }
    return listHistory;
  }

  void cekTransaksi() async {
    for (var i = 0; i < listHistory.length; i++) {
      var orderId = listHistory[i].orderId;
      await http.get(Uri.parse(BaseUrl.cekTransaksiProduk + orderId));
    }
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listHistory) {
      setState(() => listHistory = _listHistory);
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
                listHistory = snapshot.data!;
                return Container(
                  height: double.infinity,
                  // margin: EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                      itemCount: listHistory.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var _data = listHistory[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailHistoryTrx(history: _data)));
                          },
                          child: CardTrxHistory(history: _data),
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
