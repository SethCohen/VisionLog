import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/provider/dream_documents_provider.dart';
import 'package:visionlog/widgets/dream.dart';

class DreamsPage extends StatefulWidget {
  DreamsPage({Key? key}) : super(key: key);

  @override
  _DreamsPageState createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
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
  void initState() {
    super.initState();
  }

  Widget _buildDreamsList(BuildContext context) {
    var docs = context.watch<Documents>().documents;

    if (docs != null) {
      return ListView(
        padding: const EdgeInsets.all(16.0),
        children: docs.map((DocumentSnapshot document) =>
            _buildDream(context, document))
            .toList(),
      );
    } else {
      return CircularProgressIndicator();
    }
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
                    .format(dream.datetime),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dreams'),
      ),
      body: _buildDreamsList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDreamWidget,
        tooltip: 'Add Dream',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddDreamWidget() async {
    Navigator.pushNamed(context, '/addDream').then((_) => setState(() {}));
  }

  Future<void> _showDreamEntree(dream) async {
    Navigator.pushNamed(context, '/dreamEntree', arguments: (dream)).then((_) => setState(() {}));
  }
}
