import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'model/dream.dart';

class PieChart extends StatelessWidget {
  final List<LinearSales> data = [LinearSales(0, 100),
    LinearSales(1, 75),
    LinearSales(2, 25),
    LinearSales(3, 5),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<LinearSales, int>> _series = [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      ),
    ];

    return new charts.PieChart(_series,
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 100,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}