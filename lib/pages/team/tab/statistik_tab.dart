import 'package:flutter/material.dart';

class StatistikTab extends StatefulWidget {
  const StatistikTab({Key? key}) : super(key: key);

  @override
  State<StatistikTab> createState() => _StatistikTabState();
}

class _StatistikTabState extends State<StatistikTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('statistik nih'),
      ),
    );
  }
}
