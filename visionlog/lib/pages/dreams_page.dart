import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visionlog/widgets/dream_list.dart';

class DreamsPage extends StatefulWidget {
  DreamsPage({Key? key}) : super(key: key);

  @override
  _DreamsPageState createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dreams'),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DreamList();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDreamWidget,
        tooltip: 'Add Dream',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddDreamWidget() async {
    await Navigator.pushNamed(context, '/addDream');
  }
}
