import 'package:flutter/material.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/pages/home/content/banner.dart';
import 'package:persedikab_app/pages/home/content/berita.dart';
import 'package:persedikab_app/pages/home/content/jadwal.dart';
import 'package:persedikab_app/pages/home/content/next_match.dart';
import 'package:persedikab_app/pages/home/content/pemain.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              BannerHome(),
              SizedBox(height: 20),
              ContentNextMatch(),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15))),
                  padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: ContentJadwal()),
              SizedBox(height: 20),
              Container(
                // padding: EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  "Berita",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
              ),
              ContentBerita(),
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Text(
                    "Baca Selengkapnya...",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  onTap: () {
                    print("klik selengkapnya");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNav(
                                selectLayer: 2,
                              )),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                // padding: EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  "Pemain",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
              ),
              Container(
                  width: double.infinity, height: 200, child: ContentPemain()),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Text(
                    "Lihat Selengkapnya...",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  onTap: () {
                    print("klik selengkapnya");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNav(
                                selectLayer: 3,
                              )),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
