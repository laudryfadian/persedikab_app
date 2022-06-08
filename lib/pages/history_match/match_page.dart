import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/history_match/history.dart';
import 'package:persedikab_app/pages/history_match/jadwal.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                ListTile(
                    title: Text(
                  'Pertandingan',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                )),
                Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Color(0xFF9F9F9F),
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14.0, color: Color(0xFF9F9F9F)),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF1C1C1C),
                      fontWeight: FontWeight.bold,
                    ).copyWith(fontSize: 25.0),
                    tabs: const [Tab(text: 'Jadwal'), Tab(text: 'History')],
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [JadwalPage(), HistoryPage()],
          )),
    );
  }
}
