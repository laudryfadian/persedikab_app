import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
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
        child: Text('oke'),
      ),
    );
  }
}
