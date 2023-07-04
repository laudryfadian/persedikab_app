import 'package:flutter/material.dart';
import 'package:persedikab_app/models/merchandise.dart';

class CardMerchandise extends StatelessWidget {
  const CardMerchandise({Key? key, required this.merchandise})
      : super(key: key);
  final Data merchandise;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Image.network(merchandise.gambar[0], fit: BoxFit.fitWidth),
            ),
            Column(
              children: [
                Text(
                  merchandise.nama,
                  style: TextStyle(fontSize: 15),
                  maxLines: 1,
                ),
                Text(
                  "Rp. " + merchandise.harga.toString(),
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
