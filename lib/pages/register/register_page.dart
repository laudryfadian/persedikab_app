import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persedikab_app/pages/login/login_page.dart';
import 'package:persedikab_app/pages/otp_verify/otp.dart';
import '../../widget/header_widget.dart';
import '../../common/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/network/network.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController jkController = TextEditingController();
  TextEditingController ttlController = TextEditingController();
  String _date = "Belum ada";
  final List<String> items = ['Laki - Laki', 'Perempuan'];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/logo.png'),
                                height: 90,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: TextFormField(
                            controller: namaController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Nama Lengkap', 'Masukkan nama lengkapmu'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper().textInputDecoration(
                                "Email", "Masukkan emailmu"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Masukkan email yang valid!";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Masukkan passwordmu"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Password tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: nohpController,
                            decoration: ThemeHelper().textInputDecoration(
                                "Nomor HP", "Masukkan nomor hpmu"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Masukkan nomor hp yang valid!";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: alamatController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Alamat', 'Masukkan alamat rumahmu'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        // Container(
                        //   child: TextFormField(
                        //     controller: jkController,
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         'Jenis Kelamin', 'Masukkan jenis kelamin'),
                        //   ),
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        // ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Pilih jenis kelamin',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: _addDividersAfterItems(items),
                            customItemsIndexes: _getDividersIndexes(),
                            customItemsHeight: 4,
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Tanggal Lahir",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(1960, 1, 1),
                                maxTime: DateTime(2022, 12, 31),
                                onConfirm: (date) {
                              print('confirm $date');
                              _date =
                                  '${date.day} - ${date.month} - ${date.year}';
                              setState(() {});
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.id);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            " $_date",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "  Ubah",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Daftar".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   // Navigator.of(context).pushAndRemoveUntil(
                              //   //     MaterialPageRoute(
                              //   //         builder: (context) => ProfilePage()),
                              //   //     (Route<dynamic> route) => false);
                              // }
                              setState(() {
                                isLoading = true;
                                register();
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register() async {
    print(_date);
    if (namaController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        nohpController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var response = await http.post(Uri.parse(BaseUrl.register),
          body: ({
            "nama": namaController.text,
            "email": emailController.text,
            "nohp": nohpController.text,
            "password": passwordController.text,
            "jk": selectedValue,
            // "ttl": ttlController.text,
            "ttl": _date,
            "alamat": alamatController.text
          }));
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        sendOtp();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Harus di isi semua!')));
    }
    setState(() {
      isLoading = false;
    });
  }

  void sendOtp() async {
    print("Kirim otp");
    var response =
        await http.post(Uri.parse(BaseUrl.newOtp + nohpController.text));
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Harap cek code otp di whatsapp")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => OTP(
                  nohp: nohpController.text,
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Terjadi kesalahan, mohon ulangi sesaat lagi")));
    }
  }
}
