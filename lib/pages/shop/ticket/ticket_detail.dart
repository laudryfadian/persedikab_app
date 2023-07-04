import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/models/tiket.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/transaction_status.dart';
import 'package:persedikab_app/widget/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TiketDetail extends StatefulWidget {
  const TiketDetail({Key? key, required this.tiket}) : super(key: key);
  final Data tiket;

  @override
  State<TiketDetail> createState() => _TiketDetailState();
}

class _TiketDetailState extends State<TiketDetail> {
  int jumlah = 1;
  int totalHarga = 0;
  String dropdownValue = 'BRI';

  @override
  void initState() {
    totalHarga = widget.tiket.harga;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tiket.judul),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: RaisedButton(
          color: Colors.redAccent,
          onPressed: () {
            buy();
            // showDialog<String>(
            //     context: context,
            //     builder: (BuildContext context) => DialogAlert(
            //           penerima: 'oke',
            //           title: widget.tiket.judul,
            //           desc:
            //               "Apakah data kamu sudah sesuai dan ingin melanjutkan ke transaksi?",
            //           halaman: TransactionStatus(),
            //         ));
          },
          child: Text("Beli Sekarang!", style: TextStyle(color: Colors.white)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 250,
                child: Image.network(
                    "https://lirp.cdn-website.com/a667e1a7/dms3rep/multi/opt/ticket-640w.png")),
            SizedBox(height: 10),
            Container(
                alignment: Alignment.topLeft,
                child: Text(widget.tiket.judul,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ))),
            SizedBox(height: 10),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stadion: " + widget.tiket.stadion,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.tiket.jam,
                  style: TextStyle(fontSize: 16),
                )
              ],
            )),
            SizedBox(height: 10),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Rp. " + widget.tiket.harga.toString(),
                  style: TextStyle(fontSize: 19),
                )),
            Container(
                alignment: Alignment.topRight,
                child: Text(
                  widget.tiket.tanggal,
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 10),
            Container(
                alignment: Alignment.topRight,
                child: Text(
                  "Stok: " + widget.tiket.stok.toString(),
                  style: TextStyle(color: Colors.red),
                )),
            Divider(color: Colors.grey, height: 30),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text("Jumlah Beli"),
            //       Container(
            //         child: Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 print("kurang bos");
            //                 setState(() {
            //                   if (jumlah == 1) {
            //                     jumlah = 1;
            //                   } else {
            //                     jumlah = jumlah - 1;
            //                     totalHarga = totalHarga - widget.tiket.harga;
            //                   }
            //                 });
            //               },
            //               child: Icon(CupertinoIcons.minus_circle_fill,
            //                   color: Colors.redAccent),
            //             ),
            //             SizedBox(width: 10),
            //             Text(jumlah.toString()),
            //             SizedBox(width: 10),
            //             InkWell(
            //               onTap: () {
            //                 print("tambah bos");
            //                 setState(() {
            //                   jumlah = jumlah + 1;
            //                   totalHarga = totalHarga + widget.tiket.harga;
            //                 });
            //               },
            //               child: Icon(
            //                 CupertinoIcons.add_circled_solid,
            //                 color: Colors.redAccent,
            //               ),
            //             )
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Harga"),
                  Text(
                    "Rp. " + totalHarga.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void buy() async {
    print("beli");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser");
    var nama = pref.getString("namaUser");

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => DialogAlert(
              title: widget.tiket.judul,
              desc:
                  "Apakah data kamu sudah sesuai dan ingin melanjutkan ke transaksi?",
              halaman: TransactionStatus(
                trxType: "tiket",
                urlGambar:
                    "https://lirp.cdn-website.com/a667e1a7/dms3rep/multi/opt/ticket-640w.png",
                jumlahBeli: 1,
                namaProduk: widget.tiket.judul,
                ukuran: "",
                hargaProduk: widget.tiket.harga,
                totalHarga: totalHarga,
                penerima: nama.toString(),
                idProduk: widget.tiket.id,
              ),
            ));
    // var idUser = pref.getString("idUser");
    // var response =
    //     await http.post(Uri.parse(BaseUrl.transaksiTiket + idUser.toString()),
    //         headers: {"Content-type": "Application/json"},
    //         body: jsonEncode({
    //           "nama_bank": dropdownValue,
    //           "customer": {
    //             "email": pref.getString("emailUser"),
    //             "name": pref.getString("namaUser"),
    //             "phone": pref.getString("nohpUser"),
    //             "address": pref.getString("alamatUser")
    //           },
    //           "items": {
    //             "idProduk": widget.tiket.id,
    //             "price": widget.tiket.harga,
    //             "quantity": jumlah,
    //             "name": widget.tiket.judul
    //           }
    //         }));
    // // print(data);
    // print(response.body);
    // if (response.statusCode == 200) {
    //   final body = jsonDecode(response.body)['result']['data'];
    //   print(body);
    // } else {
    //   print("error");
    // }
  }
}
