import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/pages/dreams_page.dart';
import 'package:visionlog/pages/settings_page.dart';
import 'package:visionlog/pages/statistics_page.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';


class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final user = FirebaseAuth.instance.currentUser!;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("dreams").where('user_uid', isEqualTo: user.uid).orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  context.read<Documents>().setDocuments(snapshot.data!.docs);
                });
                // TODO import any old dreams from old api

                return IndexedStack(
                  children: [
                    DreamsPage(),
                    StatisticsPage(),
                    SettingsPage(),
                  ],
                  index: _selectedIndex,
                );
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