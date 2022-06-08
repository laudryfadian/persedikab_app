import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/match.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<Data> listJadwal = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.pertandingan));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listJadwal = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return listJadwal;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listJadwal) {
      setState(() => listJadwal = _listJadwal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<List<Data>>(
            future: _fetchData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
              if (snapshot.hasData) {
                listJadwal = snapshot.data!;
                return Container(
                  height: double.infinity,
                  child: ListView.builder(
                      itemCount: listJadwal.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var _data = listJadwal[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Text(
                                            _data.tanggal,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade600,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Text(
                                          _data.jam,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      _data.logo.logo1),
                                                  fit: BoxFit.contain)),
                                        ),
                                      ),
                                      Text("VS"),
                                      Container(
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      _data.logo.logo2),
                                                  fit: BoxFit.contain)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(_data.stadion),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.red,
                                  )
                                ],
                              )),
                        );
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red.shade900,
                  ),
                );
              }
            },
          ),
        ));
  }
}
