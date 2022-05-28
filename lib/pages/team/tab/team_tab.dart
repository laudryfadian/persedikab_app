import 'package:flutter/material.dart';

class TeamTab extends StatefulWidget {
  const TeamTab({Key? key}) : super(key: key);

  @override
  State<TeamTab> createState() => _TeamTabState();
}

class _TeamTabState extends State<TeamTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('team nih'),
      ),
    );
  }
}
