import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/models/tikethistory.dart';
import 'package:persedikab_app/pages/shop/ticket/struk_tiket.dart';

class DetailHistoryTiket extends StatelessWidget {
  const DetailHistoryTiket({Key? key, required this.history}) : super(key: key);
  final Data history;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Transaksi"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: double.infinity,
                color: history.paymentDetails.transactionStatus == "pending"
                    ? Colors.yellowAccent
                    : history.paymentDetails.transactionStatus == "settlement"
                        ? Colors.greenAccent.shade400
                        : Colors.redAccent,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          history.status,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 13),
                    Container(
                      child: Text(
                        "Terima kasih sudah membeli produk original dari persedikab kediri, tunggu produk terbaru dari kami selanjutnya!",
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          child: Image.network(
                              "https://lirp.cdn-website.com/a667e1a7/dms3rep/multi/opt/ticket-640w.png"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                history.itemDetails.name,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                  history.itemDetails.quantity.toString() +
                                      " Tiket",
                                  style: TextStyle(fontSize: 15)),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                  "Rp. " + history.itemDetails.price.toString(),
                                  style: TextStyle(fontSize: 15)),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(
                      thickness: 3,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("Total Pesanan"),
                        ),
                        Container(
                          child: Text("Rp. " + history.grossAmount.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Detail Tiket",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Laga"),
                        Text(history.itemDetails.idTiket.jenis)
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Stadion"),
                        Text(history.itemDetails.idTiket.stadion)
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jam"),
                        Text(history.itemDetails.idTiket.jam)
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tanggal"),
                        Text(history.itemDetails.idTiket.tanggal)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                  height:
                      history.paymentDetails.transactionStatus == "settlement"
                          ? 5
                          : 0),
              history.paymentDetails.transactionStatus == "settlement"
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lihat tiket",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          RaisedButton(
                              color: Colors.red,
                              child: Text(
                                "Tiket",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                var struk = history.tiketCode.toList();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StrukTiket(
                                              jam: history
                                                  .itemDetails.idTiket.jam,
                                              stadion: history
                                                  .itemDetails.idTiket.stadion,
                                              pertandingan: history
                                                  .itemDetails.idTiket.judul,
                                              kode: struk,
                                            )));
                              })
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Pembayaran",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bank"),
                        Text(history.paymentDetails.vaNumbers[0].bank)
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kode VA"),
                        Text(
                          history.paymentDetails.vaNumbers[0].vaNumber,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nomor Pemesanan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(history.orderId,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tanggal Transaksi"),
                          Text(history.tanggal)
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
