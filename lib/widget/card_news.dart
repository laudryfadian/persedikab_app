import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/constant.dart';
import 'package:persedikab_app/models/news.dart';

class CardNews extends StatefulWidget {
  final Data news;
  const CardNews({Key? key, required this.news}) : super(key: key);

  @override
  State<CardNews> createState() => _CardNewsState();
}

class _CardNewsState extends State<CardNews> {
  bool _like = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kGrey3, width: 1.0)),
      child: Row(
        children: [
          Container(
            width: 90.0,
            height: 135.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    image: NetworkImage(widget.news.gambar),
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
                  widget.news.judul,
                  style: kTitleCard,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  widget.news.isi,
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
                            widget.news.tanggal,
                            style: kDetailContent,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_like == false) {
                            _like = true;
                          } else {
                            _like = false;
                          }
                        });

                        print(_like);
                      },
                      child: Container(
                        child: Icon(CupertinoIcons.heart_fill,
                            color: _like == true ? Colors.red : Colors.grey),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
