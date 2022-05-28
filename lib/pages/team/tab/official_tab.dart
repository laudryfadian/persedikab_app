import 'package:flutter/material.dart';

class OfficialTab extends StatefulWidget {
  const OfficialTab({Key? key}) : super(key: key);

  @override
  State<OfficialTab> createState() => _OfficialTabState();
}

class _OfficialTabState extends State<OfficialTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('official nih'),
      ),
    );
  }
}
