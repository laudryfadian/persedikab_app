import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/match.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/widget/card_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Data> listHistory = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.history));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listHistory = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return listHistory;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listHistory) {
      setState(() => listHistory = _listHistory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<Data>>(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.hasData) {
            listHistory = snapshot.data!;
            return Container(
              height: double.infinity,
              child: ListView.builder(
                  itemCount: listHistory.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var _data = listHistory[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 135.0,
                        child: HistoryCard(history: _data),
                      ),
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
