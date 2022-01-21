import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:visionlog/provider/dream_documents_provider.dart';
import 'package:visionlog/widgets/dream.dart';

class FeelPieChart extends StatelessWidget {

  FeelPieChart(this.dateSelected);

  final DateTime dateSelected;

  @override
  Widget build(BuildContext context) {
    var docs = context.watch<Documents>().documents!.map((dream) => Dream.fromMap(dream.data() as Map<String, dynamic>,
        reference: dream.reference)).where((dream) => dream.datetime.isAfter(dateSelected)).toList();
    print(docs);

    List<charts.Series<MoodCount, String>> _series = [
      charts.Series<MoodCount, String>(
        id: 'Mood',
        domainFn: (MoodCount mood, _) => mood.feel,
        measureFn: (MoodCount mood, _) => mood.count,
        colorFn: (MoodCount mood, _) => mood.color,
        data: _buildData(docs),
        labelAccessorFn: (MoodCount row, _) =>
            '${(row.count/docs.length * 100).toStringAsFixed(1)}%',
      ),
    ];

    return new charts.PieChart<String>(_series,
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
                color: charts.MaterialPalette.white, fontSize: 15),
          ),
        ]));
  }

  _buildData(List<Dream>? docs) {
    double terribleCount = 0,
        badCount = 0,
        averageCount = 0,
        okayCount = 0,
        fantasticCount = 0;

    if (docs != null) {
      docs.forEach((Dream dream) {
        switch (dream.feel) {
          case 'terrible':
            {
              terribleCount++;
            }
            break;
          case 'bad':
            {
              badCount++;
            }
            break;
          case 'average':
            {
              averageCount++;
            }
            break;
          case 'okay':
            {
              okayCount++;
            }
            break;
          case 'fantastic':
            {
              fantasticCount++;
            }
            break;
          default:
            {
              averageCount++;
            }
            break;
        }
      });

      return [
        MoodCount("terrible", terribleCount,
            charts.ColorUtil.fromDartColor(Color(0xFF882255))),
        MoodCount("bad", badCount,
            charts.ColorUtil.fromDartColor(Color(0xFFDDCC77))),
        MoodCount("average", averageCount,
            charts.ColorUtil.fromDartColor(Color(0xFF88CCEE))),
        MoodCount("okay", okayCount,
            charts.ColorUtil.fromDartColor(Color(0xFF117733))),
        MoodCount("fantastic", fantasticCount,
            charts.ColorUtil.fromDartColor(Color(0xFF3A27A8))),
      ];
    }
  }
}

class MoodCount {
  final String feel;
  final double count;
  final charts.Color color;

  MoodCount(this.feel, this.count, this.color);

  String toString() {
    return '\nMoodCount{feel: $feel, count: $count}';
  }
}
