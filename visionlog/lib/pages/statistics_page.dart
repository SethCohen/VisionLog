import 'package:flutter/material.dart';
import 'package:visionlog/widgets/feel_pie_chart.dart';
import 'package:visionlog/widgets/numerical_chart.dart';
import 'package:visionlog/widgets/type_pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTime _dateSelected = DateTime.fromMillisecondsSinceEpoch(0);
  dynamic _chart = FeelPieChart(DateTime.fromMillisecondsSinceEpoch(0));
  String _chartDropdownValue = 'Feel';
  String _dateDropdownValue = 'All-Time';

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
            DropdownButtonHideUnderline(
              child: DropdownButton(
                alignment: Alignment.centerRight,
                isDense: true,
                dropdownColor: Colors.black,
                value: _chartDropdownValue,
                iconEnabledColor: Colors.white,
                onChanged: (String? newValue) {
                  setState(() {
                    _chartDropdownValue = newValue!;
                    switch (newValue) {
                      case 'Feel':
                        _chart = FeelPieChart(_dateSelected);
                        break;
                      case 'Type':
                        _chart = TypePieChart(_dateSelected);
                        break;
                      case 'Numerical':
                        _chart = NumericalChart(_dateSelected);
                        break;
                      default:
                        _chart = FeelPieChart(_dateSelected);
                    }
                  });
                },
                icon: Icon(Icons.pie_chart),
                items: <String>[
                  'Feel',
                  'Type',
                  'Numerical',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                alignment: Alignment.centerRight,
                isDense: true,
                dropdownColor: Colors.black,
                iconEnabledColor: Colors.white,
                value: _dateDropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _dateDropdownValue = newValue!;
                    switch (newValue) {
                      case 'All-Time':
                        _dateSelected = DateTime.fromMillisecondsSinceEpoch(0);
                        break;
                      case 'Yearly':
                        _dateSelected =
                            DateTime.now().subtract(const Duration(days: 365));
                        break;
                      case 'Semi Yearly':
                        _dateSelected =
                            DateTime.now().subtract(const Duration(days: 180));
                        break;
                      case 'Quarterly':
                        _dateSelected =
                            DateTime.now().subtract(const Duration(days: 90));
                        break;
                      case 'Monthly':
                        _dateSelected =
                            DateTime.now().subtract(const Duration(days: 30));
                        break;
                      case 'Weekly':
                        _dateSelected =
                            DateTime.now().subtract(const Duration(days: 7));
                        break;
                    }
                  });
                },
                icon: Icon(Icons.date_range),
                items: <String>[
                  'All-Time',
                  'Yearly',
                  'Semi Yearly',
                  'Quarterly',
                  'Monthly',
                  'Weekly'
                ].map<DropdownMenuItem<String>>((String value) {
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
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
                child: _chart,
              )
            ],
          ),
        ));
  }
}
