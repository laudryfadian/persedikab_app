import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/tiket.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/ticket/ticket_detail.dart';
import 'package:persedikab_app/widget/card_tiket.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  List<Data> listTiket = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.tiket));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listTiket = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
        print(listTiket);
      }
    } catch (e) {
      print(e);
    }
    return listTiket;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listTiket) {
      setState(() => listTiket = _listTiket);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ticket'),
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: FutureBuilder<List<Data>>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: double.infinity,
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: snapshot.data!
                          .map((_data) => GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                      child: Image.network(
                                          "https://lirp.cdn-website.com/a667e1a7/dms3rep/multi/opt/ticket-640w.png"),
                                    ),
                                    Text(
                                      _data.judul,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      "Rp. " + _data.harga.toString(),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TiketDetail(
                                              tiket: _data,
                                            )),
                                  );
                                },
                              ))
                          .toList(),
                    ),
                    padding: EdgeInsets.only(bottom: 10.0),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.red.shade900,
                  ));
                }
              },
            ),
          ),
        ));
  }
}
