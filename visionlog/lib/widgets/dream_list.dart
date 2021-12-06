import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'dream.dart';

class DreamList extends StatefulWidget {
  DreamList({Key? key}) : super(key: key);

  @override
  _DreamListState createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
  final user = FirebaseAuth.instance.currentUser!;

  Map _feel = {
    'terrible': Icon(Icons.sentiment_very_dissatisfied,
        size: 36.0, color: Colors.deepPurple),
    'bad': Icon(Icons.sentiment_dissatisfied,
        size: 36.0, color: Colors.deepPurple),
    'average':
        Icon(Icons.sentiment_neutral, size: 36.0, color: Colors.deepPurple),
    'okay':
        Icon(Icons.sentiment_satisfied, size: 36.0, color: Colors.deepPurple),
    'fantastic': Icon(Icons.sentiment_very_satisfied,
        size: 36.0, color: Colors.deepPurple)
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildDreamsList(context),
    );
  }

  Future<QuerySnapshot> getDreams() async {
    return await FirebaseFirestore.instance
        .collection('dreams')
        .where('user_uid', isEqualTo: user.uid)
        .get();
  }

  Widget _buildDreamsList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getDreams(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) =>
                    _buildDream(context, document))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildDream(BuildContext context, DocumentSnapshot dreamData) {
    final dream = Dream.fromMap(dreamData.data() as Map<String, dynamic>,
        reference: dreamData.reference);
    return ListTile(
        title: Text(dream.title ?? 'No title',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dream.message ?? 'No message',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
                DateFormat.yMd()
                    .add_jm()
                    .format(dream.datetime ?? DateTime.now()),
                style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                    fontSize: 10))
          ],
        ),
        trailing: _feel[dream.feel],
        dense: true,
        onTap: () => _showDreamEntree(dream));
  }

  Future<void> _showDreamEntree(dream) async {
    await Navigator.pushNamed(context, '/dreamEntree', arguments: (dream));
  }
}
