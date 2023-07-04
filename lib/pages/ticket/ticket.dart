import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/myticket.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/ticket/barcode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({Key? key}) : super(key: key);

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  List<Data> listTiket = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var idUser = pref.getString("idUser");
      var jsonResponse = await http.get(Uri.parse(BaseUrl.mytiket + idUser!));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listTiket = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
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
          title: Text("Tiketku"),
          centerTitle: true,
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: FutureBuilder<List<Data>>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  listTiket = snapshot.data!;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        itemCount: listTiket.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var _data = listTiket[index];
                          return Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.red, Colors.redAccent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0, 0.9],
                                ),
                                // color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 100,
                                        child: Image.asset('assets/logo.png')),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Tiket Pertandingan",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        // SizedBox(height: 5),
                                        Text(
                                          _data.tiket.judul,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        // SizedBox(height: 5),
                                        Text(
                                          _data.tiket.jam,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        // SizedBox(height: 5),
                                        Text(
                                          _data.tiket.tanggal,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          _data.tiket.stadion,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _data.kode,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BarcodeTiket(
                                                    code: _data.kode,
                                                  )));
                                    },
                                    child: Text(
                                      "Lihat QR Code",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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
