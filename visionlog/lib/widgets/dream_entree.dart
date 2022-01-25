import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visionlog/widgets/dream.dart';

class DreamEntree extends StatefulWidget {
  const DreamEntree({Key? key}) : super(key: key);

  @override
  _DreamEntreeState createState() => _DreamEntreeState();
}

class _DreamEntreeState extends State<DreamEntree> {
  @override
  Widget build(BuildContext context) {
    final dream = ModalRoute.of(context)!.settings.arguments as Dream;

    Map _feel = {
      'terrible': const Icon(Icons.sentiment_very_dissatisfied,
          size: 36.0, color: Color(0xffff9595)),
      'bad': const Icon(Icons.sentiment_dissatisfied,
          size: 36.0, color: Color(0xffffdd99)),
      'average':
          const Icon(Icons.sentiment_neutral, size: 36.0, color: Color(0xffbeffb0)),
      'okay':
          const Icon(Icons.sentiment_satisfied, size: 36.0, color: Color(0xff9ecdff)),
      'fantastic': const Icon(Icons.sentiment_very_satisfied,
          size: 36.0, color: Color(0xffa49eff))
    };

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(dream.title ?? "No title"),
        actions: [
          IconButton(
              icon: const Icon(Icons.create), onPressed: () => _showEditDream(dream)),
          IconButton(
              icon: const Icon(Icons.delete),
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
                  const SizedBox(width: 10),
                  Text("Dream felt ${dream.feel}.",
                      style: const TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(DateFormat.yMd().add_jm().format(dream.datetime),
                        style: const TextStyle(
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                    if (dream.isLucid)
                      const Text("Lucid",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    if (dream.isNightmare)
                      const Text("Nightmare",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    if (dream.isRecurring)
                      const Text("Recurring",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    if (dream.isContinuous)
                      const Text("Continuous",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                  ],
                )
              ]),
              const Divider(),
              Text(dream.message ?? "No Message."),
              const Divider(),
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
