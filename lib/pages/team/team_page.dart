import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/team/tab/masukan_tab.dart';
import 'package:persedikab_app/pages/team/tab/official_tab.dart';
import 'package:persedikab_app/pages/team/tab/statistik_tab.dart';
import 'package:persedikab_app/pages/team/tab/team_tab.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _UserPageState();
}

class _UserPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                ListTile(
                    title: Text(
                  'Team',
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
                    tabs: const [
                      Tab(text: 'Team'),
                      Tab(text: 'Official'),
                      Tab(text: 'Statistik'),
                      Tab(
                        text: 'Masukan',
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [TeamTab(), OfficialTab(), StatistikTab(), MasukanTab()],
          )),
    );
  }
}
