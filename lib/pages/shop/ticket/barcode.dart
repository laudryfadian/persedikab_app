import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BarcodeTiket extends StatelessWidget {
  const BarcodeTiket({Key? key, required this.code}) : super(key: key);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
        centerTitle: true,
      ),
      body: Center(
          child: QrImage(
        data: code,
        version: QrVersions.auto,
        size: 320,
        gapless: false,
        embeddedImage: AssetImage('assets/logo.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(80, 80),
        ),
      )),
    );
  }
}
