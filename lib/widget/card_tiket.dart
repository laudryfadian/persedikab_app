import 'package:flutter/material.dart';
import 'package:persedikab_app/models/tiket.dart';

class CardTiket extends StatelessWidget {
  const CardTiket({Key? key, required this.tiket}) : super(key: key);
  final Data tiket;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20,
          ),
        ],
      ),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              child: Image.network(
                  "https://lirp.cdn-website.com/a667e1a7/dms3rep/multi/opt/ticket-640w.png",
                  fit: BoxFit.fitWidth),
            ),
            Column(
              children: [
                Text(
                  tiket.judul,
                  style: TextStyle(fontSize: 15),
                  maxLines: 1,
                ),
                Text(
                  "Rp. " + tiket.harga.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5)
              ],
            )
          ],
        ),
      ),
    );
  }
}
