import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/team.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/widget/profile_card.dart';

class TeamTab extends StatefulWidget {
  const TeamTab({Key? key}) : super(key: key);

  @override
  State<TeamTab> createState() => _TeamTabState();
}

class _TeamTabState extends State<TeamTab> {
  List<Data> listTeam = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.team));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listTeam = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return listTeam;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listTeam) {
      setState(() => listTeam = _listTeam);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Data>>(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: double.infinity,
                child: GridView.count(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 50.0),
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 20,
                  children: snapshot.data!
                      .map((_data) => GestureDetector(
                            child: GridTile(
                              child: ProfilCard(team: _data),
                            ),
                            onTap: () {},
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
    );
  }
}
