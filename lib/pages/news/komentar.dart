import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/constant.dart';
import 'package:persedikab_app/models/komentar.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/widget/card_komentar.dart';
import 'package:persedikab_app/widget/circle_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Komentar extends StatefulWidget {
  const Komentar({Key? key, required this.judul, required this.idBerita})
      : super(key: key);
  final String judul;
  final String idBerita;

  @override
  State<Komentar> createState() => _KomentarState();
}

class _KomentarState extends State<Komentar> {
  List<Data> listKomentar = [];
  TextEditingController komentarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse =
          await http.get(Uri.parse(BaseUrl.komentar + widget.idBerita));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();
        if (this.mounted) {
          setState(() {
            listKomentar = jsonItems.map<Data>((json) {
              return Data.fromJson(json);
            }).toList();
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return listKomentar;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listKomentar) {
      setState(() => listKomentar = _listKomentar);
    });
  }

  @override
  Widget build(BuildContext context) {
    String _jumlah = listKomentar.length.toString();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 2.0, 18.0, 0),
              child: Row(
                children: [
                  CircleButton(
                    icon: Icons.arrow_back_ios,
                    onTap: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Komentar",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                // color: Colors.black12,
                child: SingleChildScrollView(
                    child: Container(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            widget.judul,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 29),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_jumlah),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Komentar")
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: Colors.red,
                        ),
                        ListView.builder(
                          itemCount: listKomentar.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            var _data = listKomentar[index];
                            if (_jumlah == "0") {
                              return Center(
                                child: Text("Data Kosong"),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(
                                    _data.users.nama,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: Text(
                                    _data.isi,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ))),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: komentarController,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    hintText: 'Enter text',
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    kirimKomentar(context);
                  },
                  child: Text("Kirim")),
            ],
          ),
        ],
      ),
    );
  }

  void kirimKomentar(BuildContext context) async {
    print(komentarController.text);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(BaseUrl.kirimKomentar),
        body: ({
          "users": pref.getString("idUser"),
          "beritas": widget.idBerita,
          "isi": komentarController.text
        }));
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _fetchData();
      komentarController.text = "";
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body['message'])));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body['message'])));
    }
  }
}
