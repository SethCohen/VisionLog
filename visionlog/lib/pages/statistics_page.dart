import 'package:flutter/material.dart';
import 'package:visionlog/statistics/mood_pie_chart.dart';
import 'package:visionlog/statistics/type_count.dart';
import 'package:visionlog/statistics/type_pie_chart.dart';

import '../model/dream_model.dart';
import '../statistics/mood_count.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String _dropdownValue = 'All-time';
  final _model = DreamModel();

  Future myMoodFuture;
  Future myTypeFuture;

  @override
  void initState() {
    myMoodFuture = _getMoodCount();
    myTypeFuture = _getTypeCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Statistics'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                dropdownColor: const Color(0xFF15151C),
                value: _dropdownValue,
                icon: Icon(Icons.date_range, color: Colors.white,),
                iconSize: 24,
                style: TextStyle(color: Colors.white, fontSize: 17.5),
                underline: Container(
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    _dropdownValue = newValue;
                    myMoodFuture = _getMoodCount();
                    myTypeFuture = _getTypeCount();
                  });
                },
                items: <String>['All-time', 'Yearly', 'Monthly', 'Weekly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              FutureBuilder(
                  future: myMoodFuture,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: 300.0,
                        height: 300.0,
                        child: MoodPieChart(
                          data: snapshot.data,
                        ),
                      );
                    } else if (snapshot.hasData == false) {
                      print('No data');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(child: new CircularProgressIndicator());
                  }),
              Divider(
                color: Colors.white70,
              ),
              FutureBuilder(
                  future: myTypeFuture,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: 300.0,
                        height: 300.0,
                        child: TypePieChart(
                          data: snapshot.data,
                        ),
                      );
                    } else if (snapshot.hasData == false) {
                      print('No data');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(child: new CircularProgressIndicator());
                  }),
              Divider(
                color: Colors.white70,
              ),
              // TODO in Numbers statistics
              // TODO date range statistics
            ],
          ),
        ));
  }

  Future _getMoodCount() async {
      List<MoodCount> moodCount = await _model.getDreamsMoodCount(_dropdownValue);
      print("Mood count: " + moodCount.toString());

      await Future.delayed(Duration(seconds: 1));

      return moodCount;
  }

  Future _getTypeCount() async {
      List<TypeCount> typeCount = await _model.getDreamsTypeCount(_dropdownValue);
      print("Type count: " + typeCount.toString());

      await Future.delayed(Duration(seconds: 1));

      return typeCount;
  }
}
