import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/constant.dart';
import 'package:persedikab_app/models/statistik.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';

class StatistikTab extends StatefulWidget {
  const StatistikTab({Key? key}) : super(key: key);

  @override
  State<StatistikTab> createState() => _StatistikTabState();
}

class _StatistikTabState extends State<StatistikTab> {
  List<Data> statistik = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.statistik));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        statistik = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return statistik;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_statistik) {
      setState(() => statistik = _statistik);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Data>>(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              statistik = snapshot.data!;
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TOTAL MATCH",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          statistik[0].match.toString(),
                          style: kTitleStat,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          padding: EdgeInsets.all(25.0),
                          decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          child: Column(
                            children: [
                              Text(
                                "MENANG",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                statistik[0].menang.toString(),
                                style: kTitleStat,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Text(
                                "KALAH",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                statistik[0].kalah.toString(),
                                style: kTitleStat,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "GOAL",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          statistik[0].goal.toString(),
                          style: kTitleStat,
                        )
                      ],
                    ),
                  ),
                ],
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
    );
  }
}
