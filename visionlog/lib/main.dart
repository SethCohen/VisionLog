import 'package:flutter/material.dart';
import 'file:///D:/AndroidStudioProjects/VisionLog/visionlog/lib/dream/add_dream.dart';
import 'file:///D:/AndroidStudioProjects/VisionLog/visionlog/lib/dream/dream_entree.dart';
import 'file:///D:/AndroidStudioProjects/VisionLog/visionlog/lib/pages/settings_page.dart';
import 'file:///D:/AndroidStudioProjects/VisionLog/visionlog/lib/pages/statistics_page.dart';
import 'pages/dreams_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //  App Theme
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF15151C),
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white70),
          caption: TextStyle(color: Colors.white70),
          bodyText2: TextStyle(color: Colors.white70),
          headline4: TextStyle(color: Colors.white70),
        ),

        /*buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        ),*/
        cardTheme: CardTheme(
          color: const Color(0xFF121219),
          //color: Colors.deepPurple,
          //shadowColor: Colors.deepPurple,
          shadowColor: Colors.white38,
          elevation: 3,
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/mainPage',
      routes: <String, WidgetBuilder>{
        '/addDream': (BuildContext context) => AddDream(),
        '/dreamsPage': (BuildContext context) => DreamsPage(),
        '/dreamEntree': (BuildContext context) => DreamEntree(),
        '/mainPage': (BuildContext context) => PageNavigation(),
      },
    );
  }
}

class PageNavigation extends StatefulWidget {
  PageNavigation({Key key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}
class _PageNavigationState extends State<PageNavigation> {
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