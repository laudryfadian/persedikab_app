import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/team.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';

class ContentPemain extends StatefulWidget {
  const ContentPemain({Key? key}) : super(key: key);

  @override
  State<ContentPemain> createState() => _ContentPemainState();
}

class _ContentPemainState extends State<ContentPemain> {
  List<Data> listPemain = [];
  int defaultTeam = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.team));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();
        setState(() {
          listPemain = jsonItems.map<Data>((json) {
            return Data.fromJson(json);
          }).toList();
          defaultTeam = 3;
        });
      }
    } catch (e) {
      print(e);
    }
    return listPemain;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: defaultTeam,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var _data = listPemain[index];
        if (listPemain.length == 0) {
          return Center(
            child: Text("Data Kosong"),
          );
        }

        return Container(
          // margin: EdgeInsets.only(right: 5),
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Image.network(
            _data.gambar,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
