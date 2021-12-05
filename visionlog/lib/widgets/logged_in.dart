import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visionlog/pages/dreams_page.dart';
import 'package:visionlog/pages/settings_page.dart';
import 'package:visionlog/pages/statistics_page.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key? key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Dreams',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black,
          onTap: _onItemTapped,
        ),
        body: IndexedStack(
          children: [
            DreamsPage(),
            StatisticsPage(),
            SettingsPage(),
          ],
          index: _selectedIndex,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}