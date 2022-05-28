import 'package:flutter/material.dart';
import 'package:persedikab_app/common/theme_helper.dart';
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/pages/home/home_page.dart';
import 'package:persedikab_app/pages/register/register_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/authentification-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

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
      resizeToAvoidBottomInset: false,
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
                height: 550,
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNav()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text('Lupa Password'),
                      ),
                      Divider(thickness: 0, color: Colors.white),
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
}
