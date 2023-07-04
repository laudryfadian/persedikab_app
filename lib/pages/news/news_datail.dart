import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/constant.dart';
import 'package:persedikab_app/models/news.dart';
import 'package:persedikab_app/pages/news/komentar.dart';
import 'package:persedikab_app/widget/circle_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true),
                    items: detail.gambar
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                      image: NetworkImage(e),
                                      fit: BoxFit.cover)),
                            ))
                        .toList(),
                  ),
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
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  var idUser = pref.getString("idUser");
                  idUser != null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Komentar(
                                    judul: detail.judul,
                                    idBerita: detail.sId,
                                  )))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap login dulu')));
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
