import 'package:flutter/material.dart';
import 'package:persedikab_app/constant.dart';
import 'package:persedikab_app/models/news.dart';
import 'package:persedikab_app/pages/news/komentar.dart';
import 'package:persedikab_app/widget/circle_button.dart';

class DetailNews extends StatelessWidget {
  final Data detail;
  const DetailNews({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(
              height: 12.0,
            ),
            Hero(
                tag: detail.tanggal,
                child: Container(
                  height: 220.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          image: NetworkImage(detail.gambar),
                          fit: BoxFit.fill)),
                )),
            SizedBox(
              height: 10.0,
            ),
            Text(
              detail.judul,
              style: kTitleCard.copyWith(fontSize: 28.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              detail.tanggal,
              style: kCategoryTitle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              detail.isi,
              style: descriptionStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Komentar(
                                judul: detail.judul,
                                idBerita: detail.sId,
                              )));
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Komentar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
