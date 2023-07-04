import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/match.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';

class ContentJadwal extends StatefulWidget {
  const ContentJadwal({Key? key}) : super(key: key);

  @override
  State<ContentJadwal> createState() => _ContentJadwalState();
}

class _ContentJadwalState extends State<ContentJadwal> {
  List<Data> listJadwal = [];
  int defaultJadwal = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.pertandingan));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        setState(() {
          listJadwal = jsonItems.map<Data>((json) {
            return Data.fromJson(json);
          }).toList();
          defaultJadwal = 2;
        });
      }
    } catch (e) {
      print(e);
    }
    return listJadwal;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listJadwal.length == 2 ? 1 : defaultJadwal,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        if (listJadwal.length == 0 || listJadwal.length == 1) {
          return Container();
        }
        var ke = 1;
        var _data = listJadwal[index + ke];

        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_data.logo.logo1),
                        fit: BoxFit.contain)),
              ),
              Column(
                children: [
                  Container(
                    child: Text(_data.jam),
                  ),
                  Container(child: Text(_data.tanggal))
                ],
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_data.logo.logo2),
                        fit: BoxFit.contain)),
              ),
            ],
          ),
        );
      },
    );
  }
}
