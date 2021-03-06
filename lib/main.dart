import 'package:flutter/material.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, primaryColor: Colors.red),
      home: LoginPage(),
      // home: BottomNav(selectLayer: 0),
    );
  }
}
