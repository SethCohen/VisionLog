import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/dream.dart';
import 'model/dream_model.dart';

class DreamsPage extends StatefulWidget {
  DreamsPage({Key key}) : super(key: key);

  @override
  _DreamsPageState createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
  final _model = DreamModel();

  //Initializes State future exactly once
  Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = _getDreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dreams'),
      ),
      body: FutureBuilder(
          future: myFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print('Has data');
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _showDreamEntreeWidget(snapshot.data[index]);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff2C2B30)),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                    _getIconType(snapshot.data[index].moodFeel),
                                title: Text(
                                  snapshot.data[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data[index].message,
                                  maxLines: 3,
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.topEnd,
                                child: Text(
                                  snapshot.data[index].datetime,
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            } else if (snapshot.hasData == false) {
              print('No data');
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: new CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDreamWidget,
        tooltip: 'Add Dream',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddDreamWidget() async {
    var dream = await Navigator.pushNamed(context, '/addDream');

    print('New item: $dream');

    setState(() {
      myFuture = _getDreams(); // Refreshes future
    });
  }

  Future<void> _showDreamEntreeWidget(argument) async {
    await Navigator.pushNamed(context, '/dreamEntree',
        arguments: (argument));

    setState(() {
      myFuture = _getDreams(); // Refreshes future
    });
  }

  Future _getDreams() async {
    List<Dream> dreams = await _model.getAllDreams();
    print("Database: " + dreams.toString());

    await Future.delayed(Duration(seconds: 1));

    return dreams;
  }

  //  Parses moodFeel column into displayable Icon
  _getIconType(moodFeel) {
    switch (moodFeel) {
      case 'terrible':
        {
          return Icon(
            Icons.sentiment_very_dissatisfied,
            size: 40,
            color: Colors.white70,
          );
        }
      case 'bad':
        {
          return Icon(
            Icons.sentiment_dissatisfied,
            size: 40,
            color: Colors.white70,
          );
        }
      case 'average':
        {
          return Icon(
            Icons.sentiment_neutral,
            size: 40,
            color: Colors.white70,
          );
        }
      case 'okay':
        {
          return Icon(
            Icons.sentiment_satisfied,
            size: 40,
            color: Colors.white70,
          );
        }
      case 'fantastic':
        {
          return Icon(
            Icons.sentiment_very_satisfied,
            size: 40,
            color: Colors.white70,
          );
        }
      default:
        {
          return Icon(
            Icons.sentiment_neutral,
            size: 40,
            color: Colors.white70,
          );
        }
    }
  }
}
