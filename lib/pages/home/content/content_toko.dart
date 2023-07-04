import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/shop/cloth/cloth_page.dart';
import 'package:persedikab_app/pages/shop/ticket/ticket_page.dart';

class ContentToko extends StatefulWidget {
  const ContentToko({Key? key}) : super(key: key);

  @override
  State<ContentToko> createState() => _ContentTokoState();
}

class _ContentTokoState extends State<ContentToko> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketPage()),
                );
              },
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset('assets/ticket.png'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Tiket",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClothPage()),
              );
            },
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.asset('assets/t-shirt.png'),
                ),
                SizedBox(height: 5),
                Text(
                  "Merchandise",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
