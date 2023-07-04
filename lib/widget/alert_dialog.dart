import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogAlert extends StatefulWidget {
  const DialogAlert(
      {Key? key, required this.title, required this.desc, this.halaman})
      : super(key: key);
  final String title;
  final String desc;
  final halaman;

  @override
  State<DialogAlert> createState() => _DialogAlertState();
}

class _DialogAlertState extends State<DialogAlert> {
  @override
  void initState() {
    super.initState();
  }

  // TextEditingController namaController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController alamatController = TextEditingController();
  // TextEditingController nohpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.desc),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.halaman),
            );
          },
          child: Text(
            'OK',
            style: TextStyle(color: Colors.green.shade800),
          ),
        ),
      ],
    );
  }
}
