import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/shop/cloth/cloth_page.dart';
import 'package:persedikab_app/pages/shop/ticket/ticket_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ListTile(
            title: Text(
          'Toko',
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),
        )),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: GridView.count(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
            crossAxisCount: 3,
            // childAspectRatio: 1 / 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 4,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TicketPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // border color
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(16), // border width
                      child: Center(child: Image.asset('assets/ticket.png'))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClothPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // border color
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16), // border width
                    child: Center(child: Image.asset('assets/t-shirt.png')),
                  ),
                ),
              )
            ]),
        padding: EdgeInsets.only(bottom: 10.0),
        // crossAxisCount: 5,

        // children: [

        // ],
      ),
    );
  }
}
