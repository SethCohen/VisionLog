import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:visionlog/provider/dream_documents_provider.dart';
import 'package:visionlog/widgets/dream.dart';

class TypePieChart extends StatelessWidget {
  TypePieChart(this.dateSelected);

  final DateTime dateSelected;

  @override
  Widget build(BuildContext context) {
    var docs = context
        .watch<Documents>()
        .documents!
        .map((dream) => Dream.fromMap(dream.data() as Map<String, dynamic>,
            reference: dream.reference))
        .where((dream) => dream.datetime.isAfter(dateSelected))
        .toList();

    List<charts.Series<TypeCount, String>> _series = [
      charts.Series<TypeCount, String>(
        id: 'Type',
        domainFn: (TypeCount type, _) => type.title,
        measureFn: (TypeCount type, _) => type.count,
        colorFn: (TypeCount type, _) => type.color,
        data: _buildData(docs),
        labelAccessorFn: (TypeCount row, _) =>
            '${(row.count / docs.length * 100).toStringAsFixed(1)}%',
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
    double lucidCount = 0,
        nightmareCount = 0,
        recurringCount = 0,
        continuousCount = 0;

    if (docs != null) {
      docs.forEach((Dream dream) {
        if (dream.isLucid) {
          lucidCount++;
        } else if (dream.isNightmare) {
          nightmareCount++;
        } else if (dream.isRecurring) {
          recurringCount++;
        } else if (dream.isContinuous) {
          continuousCount++;
        }
      });

      return [
        TypeCount("Lucid", lucidCount,
            charts.ColorUtil.fromDartColor(Color(0xFF6200ff))),
        TypeCount("Nightmare", nightmareCount,
            charts.ColorUtil.fromDartColor(Color(0xFF990e0e))),
        TypeCount("Recurring", recurringCount,
            charts.ColorUtil.fromDartColor(Color(0xFF88CCEE))),
        TypeCount("Continuous", continuousCount,
            charts.ColorUtil.fromDartColor(Color(0xFF117733))),
      ];
    }
  }
}

class TypeCount {
  final String title;
  final double count;
  final charts.Color color;

  TypeCount(this.title, this.count, this.color);

  String toString() {
    return '\nTypeCount{title: $title, count: $count}';
  }
}
