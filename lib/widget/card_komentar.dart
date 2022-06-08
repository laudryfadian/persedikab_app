import 'package:flutter/material.dart';

class CardKomentar extends StatelessWidget {
  const CardKomentar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama ku siapa yah",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "ini komentar",
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
