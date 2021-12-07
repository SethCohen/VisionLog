import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visionlog/widgets/dream.dart';

class DreamEntree extends StatefulWidget {
  DreamEntree({Key? key}) : super(key: key);

  @override
  _DreamEntreeState createState() => _DreamEntreeState();
}

class _DreamEntreeState extends State<DreamEntree> {
  @override
  Widget build(BuildContext context) {
    final dream = ModalRoute.of(context)!.settings.arguments as Dream;

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

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(dream.title ?? "No title"),
        actions: [
          IconButton(
              icon: Icon(Icons.create), onPressed: () => _showEditDream(dream)),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  dream.reference!.delete();
                });
                Navigator.pop(context);
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  _feel[dream.feel],
                  SizedBox(width: 10),
                  Text("Dream felt ${dream.feel}.",
                      style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(DateFormat.yMd().add_jm().format(dream.datetime),
                        style: TextStyle(
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                    if (dream.isLucid)
                      Text("Lucid",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    if (dream.isNightmare)
                      Text("Nightmare",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    if (dream.isRecurring)
                      Text("Recurring",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    if (dream.isContinuous)
                      Text("Continuous",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                  ],
                )
              ]),
              Divider(),
              Text(dream.message ?? "No Message."),
              Divider(),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _showEditDream(dream) async {
    Navigator.pushNamed(context, '/editDream', arguments: (dream))
        .then((_) => setState(() {}));
  }
}
