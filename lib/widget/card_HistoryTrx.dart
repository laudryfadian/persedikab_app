import 'package:flutter/material.dart';
import 'package:persedikab_app/models/transaction_detail.dart';

class CardTrxHistory extends StatelessWidget {
  const CardTrxHistory({Key? key, required this.history}) : super(key: key);
  final Data history;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              history.itemDetails[0].idProduk.nama,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 80,
                child: Image.network(history.itemDetails[0].idProduk.gambar),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        history.itemDetails[0].quantity.toString() + " Produk",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "Size " + history.itemDetails[0].ukuran.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text("Rp. " + history.grossAmount.toString(),
                            style: TextStyle(fontSize: 14))),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text("Status"),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(history.status,
                    style: TextStyle(
                        fontSize: 14,
                        color: history.paymentDetails.transactionStatus ==
                                "pending"
                            ? Colors.yellow.shade700
                            : history.paymentDetails.transactionStatus ==
                                    "settlement"
                                ? Colors.green.shade700
                                : Colors.red)),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text("Tanggal"),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(history.tanggal),
              )
            ],
          ),
          // Divider(color: Colors.grey.shade400, thickness: 2),
          SizedBox(height: 10),
          Divider(color: Colors.redAccent, thickness: 2),
          Container(
            child: Text(
              "Total Pesanan : Rp. " + history.itemDetails[0].price.toString(),
              style: TextStyle(fontSize: 15),
            ),
          ),
          Divider(color: Colors.redAccent, thickness: 2),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
