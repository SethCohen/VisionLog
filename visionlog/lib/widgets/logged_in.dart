import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/pages/dreams_page.dart';
import 'package:visionlog/pages/settings_page.dart';
import 'package:visionlog/pages/statistics_page.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';
import 'package:path_provider/path_provider.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  CollectionReference dreams = FirebaseFirestore.instance.collection('dreams');
  final user = FirebaseAuth.instance.currentUser!;

  int _selectedIndex = 0;

  static const List<Widget> _widgetPages = <Widget>[
    DreamsPage(),
    StatisticsPage(),
    SettingsPage(),
  ];

  _importOldDreams() async {
    final Directory? directory = await getApplicationSupportDirectory();

    List files = directory!.listSync();
    RegExp exp = RegExp(
        r"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2});(?<hour>\d{2}):(?<minute>\d{2}):\d{2}-(?<type>\d)\.txt");

    // 1 is regular
    // 2 is lucid
    // 3 is euphoric
    // 4 is thriller
    // 5 is nightmare
    // 6 is lucid nightmare

    for (File file in files) {
      final strFile = file.path.split('/').last;
      if (exp.hasMatch(strFile)) {
        final match = exp.firstMatch(strFile);
        final contents = await file.readAsString();

        switch (match!.namedGroup("type")) {
          case "1":
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'average',
                contents,
                false,
                false);
            break;
          case "2":
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'average',
                contents,
                false,
                true);
            break;
          case "3":
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'fantastic',
                contents,
                false,
                false);
            break;
          case "4":
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'bad',
                contents,
                false,
                false);
            break;
          case "5":
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'terrible',
                contents,
                true,
                false);
            break;
          case "6":
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'terrible',
                contents,
                true,
                true);
            break;
          default:
            addDream(
                strFile,
                match.namedGroup("year"),
                match.namedGroup("month"),
                match.namedGroup("day"),
                match.namedGroup("hour"),
                match.namedGroup("minute"),
                'average',
                contents,
                false,
                false);
        }

        file.delete();
      }
    }
  }

  Future<void> addDream(
      title, year, month, day, hour, minute, feel, message, nightmare, lucid) {
    return dreams
        .add({
          'user_uid': user.uid,
          'timestamp': DateTime(int.parse(year), int.parse(month),
              int.parse(day), int.parse(hour), int.parse(minute)),
          'feel': feel,
          'title': title,
          'message': message,
          'is_lucid': lucid,
          'is_nightmare': nightmare,
          'is_recurring': false,
          'is_continuous': false
        })
        .then((value) => debugPrint("Dream Added"))
        .catchError((error) => debugPrint("Failed to add dream: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("dreams")
                .where('user_uid', isEqualTo: user.uid)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  context.read<Documents>().setDocuments(snapshot.data!.docs);
                });

                _importOldDreams();

                return _widgetPages.elementAt(_selectedIndex);
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}