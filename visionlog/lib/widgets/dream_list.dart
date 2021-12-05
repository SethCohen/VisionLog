import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dream.dart';

class DreamList extends StatefulWidget {
  DreamList({Key? key}) : super(key: key);

  @override
  _DreamListState createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
  final user = FirebaseAuth.instance.currentUser!;

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
    final dream = Dream.fromMap(dreamData.data() as Map<String, dynamic>, reference: dreamData.reference) ;
    return GestureDetector(
      child: ListTile(
        title: Text(dream.title??'No title'),
        subtitle: Text(dream.message??'No message'),
        trailing: Text(dream.feel??'No feel'),
      ),
      onLongPress: () {
        setState(() {
          dream.reference!.delete();
        });
      },
    );
  }
}