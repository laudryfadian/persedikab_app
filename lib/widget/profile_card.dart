import 'package:flutter/material.dart';
import 'package:persedikab_app/models/team.dart';

class ProfilCard extends StatelessWidget {
  final Data team;
  ProfilCard({required this.team});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(
            team.gambar,
            height: 180.0,
            fit: BoxFit.fitHeight,
          ),
          Text(
            team.nama,
          ),
          Text(team.jabatan)
        ],
      ),
    );
  }
}
