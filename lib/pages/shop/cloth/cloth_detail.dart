import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/models/merchandise.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/shop/transaction_status.dart';
import 'package:persedikab_app/widget/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClothDetail extends StatefulWidget {
  const ClothDetail({Key? key, required this.produk}) : super(key: key);
  final Data produk;

  @override
  State<ClothDetail> createState() => _ClothDetailState();
}

class _ClothDetailState extends State<ClothDetail> {
  int jumlah = 1;
  int totalHarga = 0;
  String dropdownValue = 'M';

  @override
  void initState() {
    totalHarga = widget.produk.harga;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk"),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: RaisedButton(
          color: Colors.redAccent,
          onPressed: () {
            buy();
          },
          child: Text("Beli Sekarang!", style: TextStyle(color: Colors.white)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true),
                    items: widget.produk.gambar
                        .map((e) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(e),
                                    fit: BoxFit.contain))))
                        .toList(),
                  )),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.produk.nama,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Ukuran : ",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.redAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['M', 'L', 'XL', 'XXL']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  "Stok : " + widget.produk.stok.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(color: Colors.grey, height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jumlah Beli"),
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print("kurang bos");
                              setState(() {
                                if (jumlah == 1) {
                                  jumlah = 1;
                                } else {
                                  jumlah = jumlah - 1;
                                  totalHarga = totalHarga - widget.produk.harga;
                                }
                              });
                            },
                            child: Icon(CupertinoIcons.minus_circle_fill,
                                color: Colors.redAccent),
                          ),
                          SizedBox(width: 10),
                          Text(jumlah.toString()),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              print("tambah bos");
                              setState(() {
                                jumlah = jumlah + 1;
                                totalHarga = totalHarga + widget.produk.harga;
                              });
                            },
                            child: Icon(
                              CupertinoIcons.add_circled_solid,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
        ),
      ),
    );
  }

  void buy() async {
    print("bayar bos");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser");
    var email = pref.getString("emailUser");
    var nama = pref.getString("namaUser");
    var nohp = pref.getString("nohpUser");
    var alamat = pref.getString("alamatUser");

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => DialogAlert(
              title: widget.produk.nama,
              desc:
                  "Apakah data kamu sudah sesuai dan ingin melanjutkan ke transaksi?",
              halaman: TransactionStatus(
                trxType: "produk",
                urlGambar: widget.produk.gambar[0],
                ukuran: dropdownValue,
                jumlahBeli: jumlah,
                namaProduk: widget.produk.nama,
                hargaProduk: widget.produk.harga,
                totalHarga: totalHarga,
                penerima: nama.toString(),
                idProduk: widget.produk.sId,
              ),
            ));

    // var response =
    //     await http.post(Uri.parse(BaseUrl.transaksi + idUser.toString()),
    //         headers: {"Content-type": "Application/json"},
    //         body: jsonEncode({
    //           "nama_bank": dropdownValue,
    //           "customer": {
    //             "email": email,
    //             "name": nama,
    //             "phone": nohp,
    //             "address": alamat
    //           },
    //           "items": [
    //             {
    //               "idProduk": widget.produk.sId,
    //               "price": widget.produk.harga,
    //               "quantity": jumlah,
    //               "name": widget.produk.nama
    //             }
    //           ]
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
