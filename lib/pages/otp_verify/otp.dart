import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/home/home_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class OTP extends StatefulWidget {
  final String email;
  const OTP({Key? key, required this.email}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Container(
            height: 400,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Masukkan code verifikasi email",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.red,
                      selectedFillColor: Colors.red.shade100,
                      activeColor: Colors.red.shade900),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: textEditingController,
                  onCompleted: (v) {
                    debugPrint("Completed");
                    cekOtp(v);
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void cekOtp(otp) async {
    print("Cek otp");
    var response = await http.post(Uri.parse(BaseUrl.cekOtp),
        body: ({"email": widget.email, "otp": otp}));
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Berhasil login")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNav(
                  selectLayer: 0,
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP salah")));
    }
  }
}
