import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persedikab_app/common/theme_helper.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:persedikab_app/pages/home/home_page.dart';
import 'package:persedikab_app/pages/otp_verify/otp.dart';
import 'package:persedikab_app/pages/register/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/authentification-screen';

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Widget userInput(TextEditingController userInput, String hintTitle,
      String hintTitle2, TextInputType keyboardType, bool securePass) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
        child: TextFormField(
          obscureText: securePass,
          controller: userInput,
          keyboardType: keyboardType,
          decoration: ThemeHelper().textInputDecoration(hintTitle, hintTitle2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Image.asset(
                  'assets/logo.png',
                  scale: 2.5,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      userInput(emailController, 'Email', 'Masukkan emailmu',
                          TextInputType.emailAddress, false),
                      userInput(
                          passwordController,
                          'Password',
                          'Masukkan passwordmu',
                          TextInputType.visiblePassword,
                          true),
                      Container(
                        height: 55,
                        padding:
                            const EdgeInsets.only(top: 5, left: 70, right: 70),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Colors.red,
                          onPressed: () {
                            print(emailController.text);
                            print(passwordController.text);
                            setState(() {
                              isLoading = true;
                            });
                            login(context);
                          },
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      // Center(
                      //   child: Text('Lupa Password'),
                      // ),
                      // Divider(thickness: 0, color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tidak punya akun ?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    print("Login");
    var response = await http.post(Uri.parse(BaseUrl.login),
        body: ({
          "email": emailController.text,
          "password": passwordController.text
        }));

    var message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body)['result']['data'];
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("idUser", body['_id']);
      await pref.setString("emailUser", body['email']);
      await pref.setString("namaUser", body['nama']);
      await pref.setString("nohpUser", body['nohp']);
      await pref.setString("alamatUser", body['alamat']);
      await pref.setString("jkUser", body['jk']);
      await pref.setString("ttlUser", body['ttl']);

      print(body["_id"]);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNav(
                  selectLayer: 0,
                )),
        (Route<dynamic> route) => false,
      );
    } else if (response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message['message'])));
      String nohp = jsonDecode(response.body)['result']['data']['nohp'];
      print(nohp);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTP(
                  nohp: nohp,
                )),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message['message'])));
    }
    setState(() {
      isLoading = false;
    });
  }
}
