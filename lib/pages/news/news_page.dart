import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/news/news_datail.dart';
import 'package:persedikab_app/widget/card_news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Data> listNews = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Data>> _fetchData() async {
    try {
      var jsonResponse = await http.get(Uri.parse(BaseUrl.berita));
      if (jsonResponse.statusCode == 200) {
        var jsonItems = json
            .decode(jsonResponse.body)['result']['data']
            .cast<Map<String, dynamic>>();

        listNews = jsonItems.map<Data>((json) {
          return Data.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return listNews;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listNews) {
      setState(() => listNews = _listNews);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ListTile(
            title: Text(
          'Berita',
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),
        )),
      ),
      body: Container(
          child: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Data>>(
          future: _fetchData(),
          builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
            if (snapshot.hasData) {
              listNews = snapshot.data!;
              return Container(
                height: double.infinity,
                margin: EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                    itemCount: listNews.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var _data = listNews[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailNews(detail: _data)));
                        },
                        child: CardNews(news: _data),
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      )),
    );
  }
}
