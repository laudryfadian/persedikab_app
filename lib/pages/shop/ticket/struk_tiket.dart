import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/shop/ticket/barcode.dart';

class StrukTiket extends StatefulWidget {
  const StrukTiket(
      {Key? key,
      required this.kode,
      required this.pertandingan,
      required this.jam,
      required this.stadion})
      : super(key: key);
  final List<String> kode;
  final String pertandingan;
  final String jam;
  final String stadion;

  @override
  State<StrukTiket> createState() => _StrukTiketState();
}

class _StrukTiketState extends State<StrukTiket> {
  // Data? struk;
  @override
  void initState() {
    super.initState();
    print(widget.kode);
    // fetchData(widget.idTiket);
  }

  // fetchData(idTiket) async {
  //   try {
  //     var jsonResponse = await http.get(Uri.parse(BaseUrl.struk + idTiket));
  //     if (jsonResponse.statusCode == 200) {
  //       var jsonItems = json.decode(jsonResponse.body)['result']['data'];
  //       setState(() {
  //         struk = jsonItems;
  //       });
  //       print(jsonItems);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Struk"),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: widget.kode.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var _data = widget.kode[index];
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.redAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.9],
                    ),
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 100, child: Image.asset('assets/logo.png')),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tiket Pertandingan",
                              style: TextStyle(fontSize: 20),
                            ),
                            // SizedBox(height: 5),
                            Text(
                              widget.pertandingan,
                              style: TextStyle(fontSize: 16),
                            ),
                            // SizedBox(height: 5),
                            Text(
                              widget.jam,
                              style: TextStyle(fontSize: 14),
                            ),
                            // SizedBox(height: 5),
                            Text(
                              widget.stadion,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      _data,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BarcodeTiket(
                                        code: _data,
                                      )));
                        },
                        child: Text(
                          "Lihat QR Code",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
