import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/merchandise.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/cloth/cloth_detail.dart';
import 'package:persedikab_app/widget/card_merchandise.dart';

class ClothPage extends StatefulWidget {
  const ClothPage({Key? key}) : super(key: key);

  @override
  State<ClothPage> createState() => _ClothPageState();
}

class _ClothPageState extends State<ClothPage> {
  List<Data> listMerch = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.merchandise));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listMerch = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return listMerch;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listMerch) {
      setState(() => listMerch = _listMerch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Merchandise'),
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
                                      child: Image.network(_data.gambar[0]),
                                    ),
                                    Text(
                                      _data.nama,
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
                                        builder: (context) =>
                                            ClothDetail(produk: _data)),
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
