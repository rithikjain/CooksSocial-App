import 'package:cooks_social/pages/mainapp/add_recipe_page.dart';
import 'package:cooks_social/pages/mainapp/alerts_page.dart';
import 'package:cooks_social/pages/mainapp/home_page.dart';
import 'package:cooks_social/pages/mainapp/profile_page.dart';
import 'package:cooks_social/pages/mainapp/search_page.dart';
import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _tabIndex = 0;
  List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    AddRecipePage(),
    AlertsPage(),
    ProfilePage(),
  ];

  void _updateTabIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
        onTap: (index) {
          _updateTabIndex(index);
        },
        currentIndex: _tabIndex,
        activeColor: Colors.black,
        reverse: true,
        items: [
          TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
          TitledNavigationBarItem(title: Text('Search'), icon: Icons.search),
          TitledNavigationBarItem(title: Text('Add Recipe'), icon: Icons.add),
          TitledNavigationBarItem(
            title: Text('Alerts'),
            icon: Icons.notifications_none,
          ),
          TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person),
        ],
      ),
      body: _pages[_tabIndex],
    );
  }
}
