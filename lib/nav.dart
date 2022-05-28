import 'package:flutter/material.dart';
import 'package:persedikab_app/pages/home/home_page.dart';
import 'package:persedikab_app/pages/news/news_page.dart';
import 'package:persedikab_app/pages/shop/shop_page.dart';
import 'package:persedikab_app/pages/team/team_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    NewsPage(),
    TeamPage(),
    ShopPage()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Persedikab'.toUpperCase()),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  iconSize: _selectedIndex == 0 ? 35 : 20,
                  color:
                      _selectedIndex == 0 ? Colors.red.shade900 : Colors.white,
                  onPressed: () {
                    _onItemTap(0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.library_books_rounded),
                  iconSize: _selectedIndex == 1 ? 35 : 20,
                  color:
                      _selectedIndex == 1 ? Colors.red.shade900 : Colors.white,
                  onPressed: () {
                    _onItemTap(1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  iconSize: _selectedIndex == 2 ? 35 : 20,
                  color:
                      _selectedIndex == 2 ? Colors.red.shade900 : Colors.white,
                  onPressed: () {
                    _onItemTap(2);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_bag_rounded),
                  iconSize: _selectedIndex == 3 ? 35 : 20,
                  color:
                      _selectedIndex == 3 ? Colors.red.shade900 : Colors.white,
                  onPressed: () {
                    _onItemTap(3);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
