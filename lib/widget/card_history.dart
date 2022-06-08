import 'package:flutter/material.dart';
import 'package:persedikab_app/models/match.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key, required this.history}) : super(key: key);

  final Data history;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      history.tanggal,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Skor",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(history.logo.logo1),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(history.klub.klub1),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(history.skor.skor1.toString()),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(history.logo.logo2),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(history.klub.klub2),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(history.skor.skor2.toString()),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
