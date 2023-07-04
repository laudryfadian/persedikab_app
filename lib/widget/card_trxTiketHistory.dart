import 'package:flutter/material.dart';
import 'package:persedikab_app/models/tikethistory.dart';

class CardHistoryTiket extends StatelessWidget {
  const CardHistoryTiket({Key? key, required this.history}) : super(key: key);
  final Data history;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bayar Tiket",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("Rp. " + history.grossAmount.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              history.itemDetails.name,
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.topLeft,
            child: Text(history.tanggal, style: TextStyle(fontSize: 14)),
          )
          //   Container(
          //     alignment: Alignment.center,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         color: Colors.red,
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(10),
          //             topRight: Radius.circular(10))),
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     child: Text(
          //       history.itemDetails.name,
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          //     ),
          //   ),
          //   SizedBox(height: 5),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         margin: EdgeInsets.only(left: 10),
          //         height: 80,
          //         child: Image.network(
          //             "https://lirp.cdn-website.com/a667e1a7/dms3rep/multi/opt/ticket-640w.png"),
          //       ),
          //       Container(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Container(
          //               padding: EdgeInsets.only(right: 10),
          //               child: Text(
          //                 history.itemDetails.quantity.toString() + " Produk",
          //                 style: TextStyle(fontSize: 14),
          //               ),
          //             ),
          //             SizedBox(height: 5),
          //             Container(
          //                 padding: EdgeInsets.only(right: 10),
          //                 child: Text(
          //                     "Rp. " + history.itemDetails.price.toString(),
          //                     style: TextStyle(fontSize: 14))),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),

          //   SizedBox(height: 5),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(left: 10),
          //         child: Text("Status"),
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(right: 10),
          //         child: Text(history.status,
          //             style: TextStyle(
          //                 fontSize: 14,
          //                 color: history.paymentDetails.transactionStatus ==
          //                         "pending"
          //                     ? Colors.yellow.shade700
          //                     : history.paymentDetails.transactionStatus ==
          //                             "settlement"
          //                         ? Colors.green.shade700
          //                         : Colors.red)),
          //       )
          //     ],
          //   ),
          //   SizedBox(height: 5),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(left: 10),
          //         child: Text("Tanggal"),
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(right: 10),
          //         child: Text(history.tanggal),
          //       )
          //     ],
          //   ),
          //   // Divider(color: Colors.grey.shade400, thickness: 2),
          //   SizedBox(height: 10),
          //   Divider(color: Colors.redAccent, thickness: 2),
          //   Container(
          //     child: Text(
          //       "Total Pesanan : Rp. " + history.itemDetails.price.toString(),
          //       style: TextStyle(fontSize: 15),
          //     ),
          //   ),
          //   Divider(color: Colors.redAccent, thickness: 2),
          //   SizedBox(height: 10)
        ],
      ),
    );
  }
}
