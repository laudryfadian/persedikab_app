import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/home/home_page.dart';
import 'package:persedikab_app/pages/login/login_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class OTP extends StatefulWidget {
  final String nohp;
  const OTP({Key? key, required this.nohp}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  bool isLoading = false;

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
                  "Masukkan code verifikasi nohp",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  widget.nohp,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    kirimUlang(widget.nohp);
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Kirim ulang",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
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
    final data = {"nohp": widget.nohp, "otp": otp};
    var response =
        await http.post(Uri.parse(BaseUrl.newKirimOtp), body: (data));
    final body = jsonDecode(response.body);
    print(data);
    print(body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Berhasil login")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP salah")));
    }
  }

  kirimUlang(nohp) async {
    print("Kirim otp");
    var response = await http.post(Uri.parse(BaseUrl.newOtp + nohp));
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Harap cek code otp di whatsapp")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Terjadi kesalahan, mohon ulangi sesaat lagi")));
    }
    setState(() {
      isLoading = false;
    });
  }
}
