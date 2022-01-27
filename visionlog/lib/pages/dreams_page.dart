import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';
import 'package:visionlog/widgets/dream.dart';

class DreamsPage extends StatefulWidget {
  const DreamsPage({Key? key}) : super(key: key);

  @override
  _DreamsPageState createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
  CollectionReference dreams = FirebaseFirestore.instance.collection('dreams');
  final user = FirebaseAuth.instance.currentUser!;

  final Map _feel = {
    'terrible': const Icon(Icons.sentiment_very_dissatisfied,
        size: 36.0, color: Color(0xffff9595)),
    'bad': const Icon(Icons.sentiment_dissatisfied,
        size: 36.0, color: Color(0xffffdd99)),
    'average': const Icon(Icons.sentiment_neutral,
        size: 36.0, color: Color(0xffbeffb0)),
    'okay': const Icon(Icons.sentiment_satisfied,
        size: 36.0, color: Color(0xff9ecdff)),
    'fantastic': const Icon(Icons.sentiment_very_satisfied,
        size: 36.0, color: Color(0xffa49eff))
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
        children: docs
            .map((DocumentSnapshot document) => _buildDream(context, document))
            .toList(),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _buildDream(BuildContext context, DocumentSnapshot dreamData) {
    final dream = Dream.fromMap(dreamData.data() as Map<String, dynamic>,
        reference: dreamData.reference);
    return ListTile(
        title: Text(dream.title ?? 'No title',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
            Text(DateFormat.yMd().add_jm().format(dream.datetime),
                style: const TextStyle(
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
        title: const Text('Dreams'),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary),
              onPressed: _restoreOldDreams,
              child: const Text('Restore Old Dreams'))
        ],
      ),
      body: _buildDreamsList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDreamWidget,
        tooltip: 'Add Dream',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddDreamWidget() async {
    Navigator.pushNamed(context, '/addDream').then((_) => setState(() {}));
  }

  Future<void> _showDreamEntree(dream) async {
    Navigator.pushNamed(context, '/dreamEntree', arguments: (dream))
        .then((_) => setState(() {}));
  }

  Future<void> _restoreOldDreams() async {
    final directory1 = await getApplicationDocumentsDirectory();
    final directory2 = await getApplicationSupportDirectory();
    final directory4 = await getExternalStorageDirectory();
    final directory6 = await getTemporaryDirectory();

    List files = [
      ...directory1.listSync(),
      ...directory2.listSync(),
      ...directory4!.listSync(),
      ...directory6.listSync()
    ];

    RegExp exp = RegExp(
        r"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2});(?<hour>\d{2}):(?<minute>\d{2}):\d{2}-(?<type>\d)\.txt");

    files =
        files.where((file) => exp.hasMatch(file.path.split('/').last)).toList();

    String strFilesList = files.isEmpty
        ? "No dreams Found."
        : files.map((e) => e.path).join('\n');
    debugPrint(strFilesList);

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: const Text('Dreams Found',
                  style: TextStyle(color: Colors.white)),
              content: SizedBox(
                height: 350,
                child: SingleChildScrollView(
                  child: Text(strFilesList),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                ),
                TextButton(
                    style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () async {
                      if (files.isEmpty) {
                        debugPrint("Empty list");
                      } else {
                        for (File file in files) {
                          String strFile = file.path.split('/').last;
                          if (exp.hasMatch(strFile)) {
                            final match = exp.firstMatch(strFile);
                            final contents = await file.readAsString();
                            final datetime = DateTime(
                              int.parse(match!.namedGroup("year")!),
                              int.parse(match.namedGroup("month")!),
                              int.parse(match.namedGroup("day")!),
                              int.parse(match.namedGroup("hour")!),
                              int.parse(match.namedGroup("minute")!),
                            );

                            switch (match.namedGroup("type")) {
                              case "1":
                                addDream(strFile, datetime, 'average', contents,
                                    false, false);
                                break;
                              case "2":
                                addDream(strFile, datetime, 'average', contents,
                                    false, true);
                                break;
                              case "3":
                                addDream(strFile, datetime, 'fantastic',
                                    contents, false, false);
                                break;
                              case "4":
                                addDream(strFile, datetime, 'bad', contents,
                                    false, false);
                                break;
                              case "5":
                                addDream(strFile, datetime, 'terrible',
                                    contents, true, false);
                                break;
                              case "6":
                                addDream(strFile, datetime, 'terrible',
                                    contents, true, true);
                                break;
                              default:
                                addDream(strFile, datetime, 'average', contents,
                                    false, false);
                            }

                            file.delete();
                          }
                        }
                      }

                      Navigator.pop(context);
                    },
                    child: const Text('Recover',
                        style: TextStyle(color: Colors.white)))
              ],
            ));
  }

  Future<void> addDream(String title, DateTime datetime, String feel,
      String contents, bool isNightmare, bool isLucid) {
    return dreams
        .add({
          'user_uid': user.uid,
          'timestamp': datetime,
          'feel': feel,
          'title': title,
          'message': contents,
          'is_lucid': isLucid,
          'is_nightmare': isNightmare,
          'is_recurring': false,
          'is_continuous': false
        })
        .then((value) => debugPrint("Dream Added"))
        .catchError((error) => debugPrint("Failed to add dream: $error"));
  }
}