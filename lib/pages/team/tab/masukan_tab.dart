import 'package:flutter/material.dart';

class MasukanTab extends StatefulWidget {
  const MasukanTab({Key? key}) : super(key: key);

  @override
  State<MasukanTab> createState() => _MasukanTabState();
}

class _MasukanTabState extends State<MasukanTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('masukan nih'),
      ),
    );
  }
}
