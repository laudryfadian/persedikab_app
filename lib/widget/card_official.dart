import 'package:flutter/material.dart';
import 'package:persedikab_app/models/official.dart';

class OfficialCard extends StatelessWidget {
  final Data official;
  OfficialCard({required this.official});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(
            official.gambar,
            height: 180.0,
            fit: BoxFit.fitHeight,
          ),
          Text(
            official.nama,
          ),
          Text(official.jabatan)
        ],
      ),
    );
  }
}
