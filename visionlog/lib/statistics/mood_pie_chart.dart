import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:visionlog/statistics/mood_count.dart';

class MoodPieChart extends StatefulWidget {
  final List<MoodCount> data;

  MoodPieChart({required this.data});

  @override
  _MoodPieChartState createState() => _MoodPieChartState();
}

class _MoodPieChartState extends State<MoodPieChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<MoodCount, String>> _series = [
      charts.Series<MoodCount, String>(
        id: 'Mood',
        domainFn: (MoodCount mood, _) => mood.moodfeel,
        measureFn: (MoodCount mood, _) => mood.count,
        colorFn: (MoodCount mood, _) => mood.color,
        data: widget.data,
        labelAccessorFn: (MoodCount row, _) =>
            '${(row.count * 100).toStringAsFixed(1)}%',
      ),
    ];

    return new charts.PieChart(_series,
        animate: true,
        behaviors: [
          new charts.DatumLegend(
            position: charts.BehaviorPosition.bottom,
            horizontalFirst: true,
            desiredMaxRows: 2,
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            cellPadding: new EdgeInsets.only(right: 8.0, bottom: 4.0),
          )
        ],
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            outsideLabelStyleSpec: charts.TextStyleSpec(
                color: charts.MaterialPalette.white, fontSize: 15),
            insideLabelStyleSpec: charts.TextStyleSpec(
                color: charts.MaterialPalette.black, fontSize: 15),
          ),
        ]));
  }
}
