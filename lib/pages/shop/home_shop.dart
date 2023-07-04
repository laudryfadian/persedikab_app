import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/shop/cloth/cloth_page.dart';
import 'package:persedikab_app/pages/shop/ticket/ticket_page.dart';

class HomeShop extends StatelessWidget {
  const HomeShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.asset('assets/ticket.png'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Tiket",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClothPage()),
                  );
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.asset('assets/t-shirt.png'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Merchandise",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
          ]),
      padding: EdgeInsets.only(bottom: 10.0),
    );
  }
}
