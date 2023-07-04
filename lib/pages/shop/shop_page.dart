import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/login/login_page.dart';
import 'package:persedikab_app/pages/shop/cloth/cloth_page.dart';
import 'package:persedikab_app/pages/shop/home_shop.dart';
import 'package:persedikab_app/pages/shop/ticket/ticket_page.dart';
import 'package:persedikab_app/pages/shop/ticket_history.dart';
import 'package:persedikab_app/pages/shop/transaction_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool isLogin = false;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser");
    if (idUser != null) {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: isLogin == true ? 3 : 0,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                ListTile(
                    title: Text(
                  'Toko',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                )),
                isLogin == true
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Color(0xFF9F9F9F),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 14.0, color: Color(0xFF9F9F9F)),
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicatorColor: Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF1C1C1C),
                            fontWeight: FontWeight.bold,
                          ).copyWith(fontSize: 25.0),
                          tabs: const [
                            Tab(text: 'Produk'),
                            Tab(text: 'History Produk'),
                            Tab(text: 'History Tiket')
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          body: isLogin == true
              ? TabBarView(
                  children: [
                    HomeShop(),
                    TransactionHistoryPage(),
                    TicketHistoryTrx()
                  ],
                )
              : Container(
                  child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login dulu!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ))),
    );
  }
}
