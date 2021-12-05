import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DreamEntree extends StatefulWidget {
  DreamEntree({Key? key}) : super(key: key);

  @override
  _DreamEntreeState createState() => _DreamEntreeState();
}

class _DreamEntreeState extends State<DreamEntree> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('test'),
        actions: [
          IconButton(icon: Icon(Icons.create), onPressed: () {
          }),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
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
              Text('Feel:'),
              Divider(),
              Divider(),
            ],
          ),
        ),
      ),
    ));
  }



}
