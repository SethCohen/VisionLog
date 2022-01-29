import 'package:flutter/material.dart';
import 'package:visionlog/widgets/feel_pie_chart.dart';
import 'package:visionlog/widgets/numerical_chart.dart';
import 'package:visionlog/widgets/type_pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
          title: const Text('Statistics'),
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
                  });
                },
                icon: const Icon(Icons.pie_chart),
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
            const VerticalDivider(
              width: 8.0,
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
                  });
                },
                icon: const Icon(Icons.date_range),
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
            ),
            const VerticalDivider(
              width: 4.0,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Flexible(
                  child: _buildChart(_chartDropdownValue, _dateDropdownValue)),
              Flexible(child: Container())
            ],
          ),
        ));
  }

  _buildChart(String selectedChart, String selectedDate) {
    DateTime _dateSelected;

    switch (selectedDate) {
      case 'All-Time':
        _dateSelected = DateTime.fromMillisecondsSinceEpoch(0);
        break;
      case 'Yearly':
        _dateSelected = DateTime.now().subtract(const Duration(days: 365));
        break;
      case 'Semi Yearly':
        _dateSelected = DateTime.now().subtract(const Duration(days: 180));
        break;
      case 'Quarterly':
        _dateSelected = DateTime.now().subtract(const Duration(days: 90));
        break;
      case 'Monthly':
        _dateSelected = DateTime.now().subtract(const Duration(days: 30));
        break;
      case 'Weekly':
        _dateSelected = DateTime.now().subtract(const Duration(days: 7));
        break;
      default:
        _dateSelected = DateTime.fromMillisecondsSinceEpoch(0);
    }

    switch (selectedChart) {
      case 'Feel':
        return FeelPieChart(_dateSelected);
      case 'Type':
        return TypePieChart(_dateSelected);
      case 'Numerical':
        return NumericalChart(_dateSelected);
      default:
        return FeelPieChart(_dateSelected);
    }
  }
}