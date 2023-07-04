import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/models/transaction_detail.dart';

class DetailHistoryTrx extends StatelessWidget {
  const DetailHistoryTrx({Key? key, required this.history}) : super(key: key);
  final Data history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Transaksi"),
        centerTitle: true,
      ),
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
              // SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(CupertinoIcons.location_solid),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Text(
                            "Alamat",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            history.customerDetails.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            history.customerDetails.phone,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            history.customerDetails.address,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          child: Image.network(
                              history.itemDetails[0].idProduk.gambar),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                history.itemDetails[0].idProduk.nama,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                  "Size " + history.itemDetails[0].ukuran,
                                  style: TextStyle(fontSize: 15)),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                  "Rp. " +
                                      history.itemDetails[0].price.toString(),
                                  style: TextStyle(fontSize: 15)),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                  history.itemDetails[0].quantity.toString() +
                                      " Produk",
                                  style: TextStyle(fontSize: 15)),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(
                                  "Ongkir Rp. " +
                                      history.itemDetails[0].ongkir.toString(),
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
                width: double.infinity,
                color: Colors.grey.shade200,
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
                        Text(history.paymentDetails.vaNumbers[0].bank
                            .toUpperCase())
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
                  color: Colors.grey.shade200,
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
