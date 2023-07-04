import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:persedikab_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:persedikab_app/nav.dart';
import 'package:persedikab_app/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Future<Data> user;

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bornController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  final List<String> items = ['Laki - Laki', 'Perempuan'];
  String? selectedValue;

  String? _date;

  @override
  void initState() {
    super.initState();
    user = fetch();
  }

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

  Future<Data> fetch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("idUser");
    selectedValue = pref.getString("jkUser");
    _date = pref.getString("ttlUser");
    final response = await http.get(Uri.parse(BaseUrl.getUserId + idUser!));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Data.fromJson(jsonDecode(response.body)['result']['data']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting Akun"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: FutureBuilder<Data>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var _user = snapshot.data!;
                    namaController.text = _user.nama;
                    emailController.text = _user.email;
                    nohpController.text = _user.nohp;
                    genderController.text = _user.jk;
                    // selectedValue = _user.jk;
                    bornController.text = _user.ttl;
                    alamatController.text = _user.alamat;
                    // return Text(snapshot.data!.nama);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/logo.png',
                              scale: 3.5,
                            ),
                          ),
                          Container(
                            child: TextField(
                              readOnly: true,
                              controller: namaController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(CupertinoIcons.person_alt),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: TextField(
                              readOnly: true,
                              controller: emailController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(CupertinoIcons.mail_solid),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: TextField(
                              readOnly: true,
                              controller: nohpController,
                              decoration: InputDecoration(
                                suffixIcon:
                                    Icon(CupertinoIcons.phone_circle_fill),
                              ),
                            ),
                          ),
                          Container(
                            child: TextField(
                              readOnly: true,
                              controller: genderController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(CupertinoIcons.person_2),
                              ),
                            ),
                          ),
                          // SizedBox(height: 10),
                          // DropdownButtonHideUnderline(
                          //   child: DropdownButton2(
                          //     icon: Icon(CupertinoIcons.person_2),
                          //     isExpanded: true,
                          //     hint: Text(
                          //       'Pilih jenis kelamin',
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         color: Theme.of(context).hintColor,
                          //       ),
                          //     ),
                          //     items: _addDividersAfterItems(items),
                          //     customItemsIndexes: _getDividersIndexes(),
                          //     customItemsHeight: 4,
                          //     value: selectedValue,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         selectedValue = value as String;
                          //         print(selectedValue);
                          //       });
                          //     },
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          TextField(
                            readOnly: true,
                            controller: bornController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(CupertinoIcons.calendar),
                            ),
                          ),
                          // RaisedButton(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(5.0)),
                          //   elevation: 4.0,
                          //   onPressed: () {
                          //     DatePicker.showDatePicker(context,
                          //         theme: DatePickerTheme(
                          //           containerHeight: 210.0,
                          //         ),
                          //         showTitleActions: true,
                          //         minTime: DateTime(2000, 1, 1),
                          //         maxTime: DateTime(2022, 12, 31),
                          //         onConfirm: (date) {
                          //       print('confirm $date');
                          //       _date =
                          //           '${date.day} - ${date.month} - ${date.year}';
                          //       setState(() {});
                          //     },
                          //         currentTime: DateTime.now(),
                          //         locale: LocaleType.id);
                          //   },
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     height: 50.0,
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: <Widget>[
                          //         Row(
                          //           children: <Widget>[
                          //             Container(
                          //               child: Row(
                          //                 children: <Widget>[
                          //                   Icon(
                          //                     Icons.date_range,
                          //                     size: 18.0,
                          //                     color: Colors.grey.shade800,
                          //                   ),
                          //                   Text(
                          //                     " $_date",
                          //                     style: TextStyle(
                          //                         color: Colors.grey.shade800,
                          //                         fontWeight: FontWeight.bold,
                          //                         fontSize: 18.0),
                          //                   ),
                          //                 ],
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //         Text(
                          //           "  Ubah",
                          //           style: TextStyle(
                          //               color: Colors.grey.shade800,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 18.0),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   color: Colors.white,
                          // ),
                          SizedBox(height: 10),
                          TextField(
                            readOnly: true,
                            controller: alamatController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(CupertinoIcons.location_solid),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // RaisedButton(
                              //   color: Colors.red.shade300,
                              //   onPressed: () {},
                              //   child: Text("Ubah"),
                              // ),
                              RaisedButton(
                                color: Colors.red,
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNav(
                                              selectLayer: 4,
                                            )),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text("Logout"),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      '${snapshot.error}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));
                  }
                  return Container(
                      height: MediaQuery.of(context).size.width * 1,
                      child: Center(child: const CircularProgressIndicator()));
                },
              )),
        ));
  }
}
