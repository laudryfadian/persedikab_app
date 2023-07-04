import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/match.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';

class ContentNextMatch extends StatefulWidget {
  const ContentNextMatch({Key? key}) : super(key: key);

  @override
  State<ContentNextMatch> createState() => _ContentNextMatchState();
}

class _ContentNextMatchState extends State<ContentNextMatch> {
  List<Data> listMatch = [];
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

        listMatch = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return listMatch;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listPertandingan) {
      setState(() => listMatch = _listPertandingan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<List<Data>>(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                listMatch = snapshot.data!;
                if (listMatch.length == 0) {
                  return Center(
                    child: Text("Tidak Ada Jadwal"),
                  );
                }
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Text(
                        'NEXT MATCH',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      color: Colors.yellow,
                      child: Text(
                        listMatch[0].liga,
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      // color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(listMatch[0].logo.logo1),
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: 100,
                                child: Text(
                                  listMatch[0].klub.klub1.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                          Text(
                            'VS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 60),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(listMatch[0].logo.logo2),
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: 100,
                                child: Text(
                                  listMatch[0].klub.klub2.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        listMatch[0].jam,
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Text(
                        listMatch[0].tanggal,
                        style: TextStyle(color: Colors.yellow),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Text(
                        listMatch[0].stadion,
                        style: TextStyle(color: Colors.yellow),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red.shade900,
                  ),
                );
              }
            },
          )),
    );
  }
}
