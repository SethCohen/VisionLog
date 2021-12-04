import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'type_count.dart';

class TypePieChart extends StatefulWidget {
  final List<TypeCount> data;

  TypePieChart({required this.data});

  @override
  _TypePieChartState createState() => _TypePieChartState();
}

class _TypePieChartState extends State<TypePieChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<TypeCount, String>> _series = [
      charts.Series<TypeCount, String>(
        id: 'Type',
        domainFn: (TypeCount type, _) => type.type,
        measureFn: (TypeCount type, _) => type.count,
        colorFn: (TypeCount type, _) => type.color,
        data: widget.data,
        labelAccessorFn: (TypeCount row, _) =>
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
          )
        ]));
  }
}
