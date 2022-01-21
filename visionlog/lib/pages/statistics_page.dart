import 'package:flutter/material.dart';
import 'package:visionlog/widgets/feel_pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  DateTime _dateSelected = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Statistics'),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  _dateSelected = value as DateTime;
                });
              },
              icon: Icon(Icons.date_range),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: DateTime.fromMillisecondsSinceEpoch(0),
                  child: Text('All-Time'),
                ),
                PopupMenuItem(
                  value: DateTime.now().subtract(const Duration(days: 365)),
                  child: Text('Yearly'),
                ),
                PopupMenuItem(
                  value: DateTime.now().subtract(const Duration(days: 180)),
                  child: Text('Semi Yearly'),
                ),
                PopupMenuItem(
                  value: DateTime.now().subtract(const Duration(days: 90)),
                  child: Text('Quarterly'),
                ),
                PopupMenuItem(
                  value: DateTime.now().subtract(const Duration(days: 30)),
                  child: Text('Monthly'),
                ),
                PopupMenuItem(
                  value: DateTime.now().subtract(const Duration(days: 7)),
                  child: Text('Weekly'),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
                child: FeelPieChart(_dateSelected),
              )
            ],
          ),
        ));
  }
}
