import 'package:flutter/material.dart';
import 'package:visionlog/widgets/feel_pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
              icon: Icon(Icons.date_range),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  value: 0,
                  child: Text('All-Time'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Yearly'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Semi Yearly'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Quarterly'),
                ),
                const PopupMenuItem(
                  value: 4,
                  child: Text('Monthly'),
                ),
                const PopupMenuItem(
                  value: 5,
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
                child: FeelPieChart(),
              )
            ],
          ),
        ));
  }
}
