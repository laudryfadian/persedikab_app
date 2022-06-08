import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/constant.dart';
import 'package:persedikab_app/models/news.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/pages/news/news_datail.dart';
import 'package:persedikab_app/widget/card_news.dart';

class ContentBerita extends StatefulWidget {
  const ContentBerita({Key? key}) : super(key: key);

  @override
  State<ContentBerita> createState() => _ContentBeritaState();
}

class _ContentBeritaState extends State<ContentBerita> {
  List<Data> listNews = [];
  int defaultBerita = 0;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.berita));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();
        setState(() {
          listNews = jsonItems.map<Data>((json) {
            return Data.fromJson(json);
          }).toList();
          defaultBerita = 2;
        });
      }
    } catch (e) {
      print(e);
    }
    return listNews;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: defaultBerita,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        var _data = listNews[index];
        if (listNews.length == 0) {
          return Center(
            child: Text("Data Kosong"),
          );
        }

        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailNews(detail: _data)));
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 90.0,
                    height: 135.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                            image: NetworkImage(_data.gambar),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _data.judul,
                          style: kTitleCard,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          _data.isi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: kDetailContent,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: kGrey1,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    _data.tanggal,
                                    style: kDetailContent,
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // setState(() {
                                //   if (_like == false) {
                                //     _like = true;
                                //   } else {
                                //     _like = false;
                                //   }
                                // });

                                // print(_like);
                              },
                              child: Container(
                                child: Icon(CupertinoIcons.heart_fill,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ));
      },
    );
  }
}
