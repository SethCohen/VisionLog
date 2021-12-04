import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/dream.dart';
import '../model/dream_model.dart';

class DreamEntree extends StatefulWidget {
  DreamEntree({Key? key}) : super(key: key);

  @override
  _DreamEntreeState createState() => _DreamEntreeState();
}

class _DreamEntreeState extends State<DreamEntree> {
  Dream _dream = Dream(id: 0, title: '', continuous: '', nightmare: '', recurring: '', message: '', lucid: '', moodFeel: '', datetime: '');
  final _model = DreamModel();

  @override
  Widget build(BuildContext context) {
    _dream = ModalRoute.of(context)!.settings.arguments as Dream;
    print(_dream);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(_dream.title),
        actions: [
          IconButton(icon: Icon(Icons.create), onPressed: () {
            _showAlertDialog(context, false);
          }),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showAlertDialog(context, true);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Feel: ' +
                  _dream.moodFeel[0].toUpperCase() +
                  _dream.moodFeel.substring(1)),
              Divider(),
              Text(_getDreamTypes(_dream)),
              Divider(),
              Text('Title:\n\t' + _dream.title),
              Divider(),
              Text('Message:\n\t' + _dream.message),
            ],
          ),
        ),
      ),
    ));
  }

  String _getDreamTypes(Dream dream) {
    String types = '';

    if (dream.lucid == 'true') types += '\nLucid';
    if (dream.nightmare == 'true') types += '\nNightmare';
    if (dream.recurring == 'true') types += '\nRecurring';
    if (dream.continuous == 'true') types += '\nContinuous';

    return types;
  }

  Future<void> _deleteDream() async {
    if (_dream.id != null) {
      _model.deleteDreamById(_dream.id);
      print("Deleted Dream at ID: " + _dream.id.toString());
    }
  }

  _showAlertDialog(BuildContext context, bool type) {
    String _text = '';
    if (type == true){
      _text = "Are you sure you would like to delete this dream?";
    }
    else {
      _text = "Are you sure you would like to edit this dream?";
    }

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {
        if (type == true){
          _deleteDream();

          int count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 2;
          });
        }
        else {
          Navigator.pushNamed(context, '/addDream',
              arguments: (_dream));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xFF121219),
      title: Text(
        _text,
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
