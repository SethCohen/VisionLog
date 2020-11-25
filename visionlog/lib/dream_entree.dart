import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/dream.dart';
import 'model/dream_model.dart';

class DreamEntree extends StatefulWidget {
  DreamEntree({Key key}) : super(key: key);

  @override
  _DreamEntreeState createState() => _DreamEntreeState();
}

class _DreamEntreeState extends State<DreamEntree> {
  @override
  Widget build(BuildContext context) {
    Dream dream = ModalRoute
        .of(context)
        .settings
        .arguments;
    print(dream);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(icon: Icon(Icons.create), onPressed: (){

              }),
              IconButton(icon: Icon(Icons.delete), onPressed: (){

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
                  Text('Feel: ' + dream.moodFeel[0].toUpperCase() + dream.moodFeel.substring(1)),
                  Divider(),
                  Text(_getDreamTypes(dream)),
                  Divider(),
                  Text('Title:\n\t' + dream.title),
                  Divider(),
                  Text('Message:\n\t' + dream.message),
                ],
              ),
            ),
          ),
        )
    );
  }

  String _getDreamTypes(Dream dream) {
    String types = '';

    if (dream.lucid == 'true') types += '\nLucid';
    if (dream.nightmare == 'true') types += '\nNightmare';
    if (dream.recurring == 'true') types += '\nRecurring';
    if (dream.continuous == 'true') types += '\nContinuous';

    return types;
  }
}