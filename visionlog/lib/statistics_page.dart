import 'package:flutter/material.dart';

import 'model/dream.dart';
import 'model/dream_model.dart';
import 'pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final _model = DreamModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PieChart(),
    );
  }

  Future _getDreams() async {
    List<Dream> dreams = await _model.getAllDreams();
    print("Database: " + dreams.toString());

    await Future.delayed(Duration(seconds: 1));

    return dreams;
  }
}