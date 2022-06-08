import 'package:flutter/material.dart';

class ClothPage extends StatefulWidget {
  const ClothPage({Key? key}) : super(key: key);

  @override
  State<ClothPage> createState() => _ClothPageState();
}

class _ClothPageState extends State<ClothPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merchandise'),
      ),
    );
  }
}
