import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransactionStatus extends StatefulWidget {
  const TransactionStatus(
      {Key? key,
      required this.urlGambar,
      required this.namaProduk,
      required this.jumlahBeli,
      required this.hargaProduk,
      required this.totalHarga,
      required this.penerima,
      required this.idProduk,
      required this.trxType,
      required this.ukuran})
      : super(key: key);
  final String urlGambar;
  final String namaProduk;
  final String ukuran;
  final int jumlahBeli;
  final int hargaProduk;
  final int totalHarga;
  final String penerima;
  final String idProduk;
  final String trxType;

  @override
  State<TransactionStatus> createState() => _TransactionStatusState();
}

class _TransactionStatusState extends State<TransactionStatus> {
  var id = "";
  var namaUser = "";
  var emailUser = "";
  var nohpUser = "";
  var alamatUser = "";
  String dropdownValue = 'BRI';
  String dropdownValue2 = 'KEDIRI';
  late Timer _timer;
  var ongkir = 0;

  bool isLoading = false;

  TextEditingController alamatController = TextEditingController();
  TextEditingController penerimaController = TextEditingController();

  @override
  void initState() {
    getSP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.shade200,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: RaisedButton(
            color: Colors.redAccent,
            onPressed: () {
              if (alamatUser.isEmpty || namaUser.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Mohon isi semua form!")));
              } else {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Apakah kamu sudah yakin untuk beli produk ini?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                // setState(() {
                                //   print("ini button beli");
                                // buy();
                                // });
                                setState(() {
                                  isLoading = true;
                                });
                                buy(context);
                              },
                              child: Text(
                                'Beli',
                                style: TextStyle(color: Colors.green.shade800),
                              ),
                            ),
                          ],
                        ));
              }
            },
            child:
                Text("Beli Sekarang!", style: TextStyle(color: Colors.white)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(widget.trxType == "produk"
                                    ? "Ubah penerima"
                                    : "Ubah pembeli"),
                                content: TextField(
                                  maxLines: 8, //or null
                                  controller: penerimaController,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Masukkan disini"),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('Cancel',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        namaUser = penerimaController.text;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Colors.green.shade800),
                                    ),
                                  ),
                                ],
                              ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  CupertinoIcons.person_alt_circle,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                child: Text(
                                  widget.trxType == "produk"
                                      ? "Penerima"
                                      : "Pembeli",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 35),
                            child: Text(
                              namaUser,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 5),
                widget.trxType == "produk"
                    ? GestureDetector(
                        onTap: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Ubah alamat"),
                                    content: TextField(
                                      maxLines: 8, //or null
                                      controller: alamatController,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Enter your text here"),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: Text('Cancel',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            alamatUser = alamatController.text;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                              color: Colors.green.shade800),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      CupertinoIcons.location_solid,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    child: Text(
                                      "Detail Alamat",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  alamatUser,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      CupertinoIcons.location_solid,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    child: Text(
                                      "Area",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 35),
                                child: DropdownButton<String>(
                                  value: dropdownValue2,
                                  // icon: const Icon(Icons.arrow_downward),
                                  // elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.redAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue2 = newValue!;
                                      switch (dropdownValue2) {
                                        case 'JAWA TIMUR':
                                          {
                                            ongkir = 10000;
                                          }
                                          break;
                                        case 'JAWA':
                                          {
                                            ongkir = 20000;
                                          }
                                          break;
                                        case 'LUAR PULAU':
                                          {
                                            ongkir = 30000;
                                          }
                                          break;
                                        default:
                                          {
                                            ongkir = 0;
                                          }
                                      }
                                    });
                                  },
                                  items: <String>[
                                    'KEDIRI',
                                    'JAWA TIMUR',
                                    'JAWA',
                                    'LUAR PULAU'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ))
                    : Container(),
                SizedBox(height: widget.trxType == "produk" ? 5 : 0),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.trxType == "produk"
                              ? "Detail Produk"
                              : "Detail Tiket",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.red,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              child: Image.network(widget.urlGambar),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.namaProduk,
                                    style: TextStyle(fontSize: 17),
                                    maxLines: 2,
                                  ),
                                  widget.trxType == "produk"
                                      ? SizedBox(height: 8)
                                      : Container(),
                                  widget.trxType == "produk"
                                      ? Text("Size " + widget.ukuran)
                                      : Container(),
                                  SizedBox(height: 8),
                                  Text(widget.jumlahBeli.toString() + " x"),
                                  SizedBox(height: 8),
                                  Text("Rp. " + widget.hargaProduk.toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: const [
                            Icon(
                              CupertinoIcons.money_dollar_circle,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Pembayaran",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Bank",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.redAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'BRI',
                                  'BCA',
                                  'BNI'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            CupertinoIcons.news_solid,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Text("Rincian Pembayaran",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.red,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Harga Produk"),
                          Text("Rp. " + widget.hargaProduk.toString())
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jumlah"),
                          Text(widget.jumlahBeli.toString() + " pcs")
                        ],
                      ),
                      widget.trxType == "produk"
                          ? SizedBox(height: 5)
                          : Container(),
                      widget.trxType == "produk"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ongkir"),
                                Text("Rp. " + ongkir.toString())
                              ],
                            )
                          : Container(),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Rp. " + (widget.totalHarga + ongkir).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void getSP() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser")!;
    var email = pref.getString("emailUser")!;
    var nama = pref.getString("namaUser")!;
    var nohp = pref.getString("nohpUser")!;
    var alamat = pref.getString("alamatUser")!;

    setState(() {
      id = idUser;
      namaUser = nama;
      emailUser = email;
      nohpUser = nohp;
      alamatUser = alamat;
    });
  }

  void buy(BuildContext context) async {
    print("beli");
    print(isLoading);
    String url =
        widget.trxType == "produk" ? BaseUrl.transaksi : BaseUrl.transaksiTiket;
    var response = await http.post(Uri.parse(url + id),
        headers: {"Content-type": "Application/json"},
        body: jsonEncode({
          "nama_bank": dropdownValue,
          "customer": {
            "email": emailUser,
            "name": namaUser,
            "phone": nohpUser,
            "address": alamatUser
          },
          "items": widget.trxType == "produk"
              ? [
                  {
                    "idProduk": widget.idProduk,
                    "price": widget.hargaProduk,
                    "quantity": widget.jumlahBeli,
                    "ongkir": ongkir,
                    "name": widget.namaProduk,
                    "ukuran": widget.ukuran
                  }
                ]
              : {
                  "idTiket": widget.idProduk,
                  "price": widget.hargaProduk,
                  "quantity": widget.jumlahBeli,
                  "name": widget.namaProduk
                }
        }));
    // print(data);
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body)['result']['data'];
      final va = jsonDecode(response.body)['result']['data']['payment_details']
          ['va_numbers'][0]['va_number'];
      final status = jsonDecode(response.body)['result']['data']['status'];
      final total = jsonDecode(response.body)['result']['data']['gross_amount'];
      print(body);
      Navigator.pop(context);

      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Status Transaksi"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Silahkan Bayar melalui nomor virtual akun bank " +
                        dropdownValue),
                    SizedBox(height: 10),
                    Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(status.toString()),
                    SizedBox(height: 5),
                    Text("Nomor VA",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(va.toString()),
                    SizedBox(height: 5),
                    Text("Total Bayar",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Rp. " + total.toString())
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNav(
                                  selectLayer: 4,
                                )),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.green.shade800),
                    ),
                  ),
                ],
              ));
    } else {
      print("error");
    }
    setState(() {
      isLoading = false;
    });
  }
}
