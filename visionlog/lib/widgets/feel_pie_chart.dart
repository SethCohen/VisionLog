import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';
import 'package:visionlog/widgets/dream.dart';

class FeelPieChart extends StatelessWidget {
  const FeelPieChart(this.dateSelected, {Key? key}) : super(key: key);

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

    List<charts.Series<FeelCount, String>> _series = [
      charts.Series<FeelCount, String>(
        id: 'Feel',
        domainFn: (FeelCount feel, _) => feel.title,
        measureFn: (FeelCount feel, _) => feel.count,
        colorFn: (FeelCount feel, _) => feel.color,
        data: _buildData(docs),
        labelAccessorFn: (FeelCount row, _) =>
            '${(row.count / docs.length * 100).toStringAsFixed(1)}%',
      ),
    ];

    return docs.isEmpty
        ? const Center(child: Text("No Dreams Founds"))
        : charts.PieChart<String>(_series,
            animate: true,
            behaviors: [
              charts.DatumLegend(
                position: charts.BehaviorPosition.bottom,
                horizontalFirst: true,
                desiredMaxRows: 2,
                outsideJustification:
                    charts.OutsideJustification.middleDrawArea,
                cellPadding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
              )
            ],
            defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
              charts.ArcLabelDecorator(
                outsideLabelStyleSpec: const charts.TextStyleSpec(
                    color: charts.MaterialPalette.white, fontSize: 15),
                insideLabelStyleSpec: const charts.TextStyleSpec(
                    color: charts.MaterialPalette.black, fontSize: 15),
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
      for (var dream in docs) {
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
      }

      return [
        FeelCount("Terrible", terribleCount,
            charts.ColorUtil.fromDartColor(const Color(0xffff9595))),
        FeelCount("Bad", badCount,
            charts.ColorUtil.fromDartColor(const Color(0xffffdd99))),
        FeelCount("Average", averageCount,
            charts.ColorUtil.fromDartColor(const Color(0xffbeffb0))),
        FeelCount("Okay", okayCount,
            charts.ColorUtil.fromDartColor(const Color(0xff9ecdff))),
        FeelCount("Fantastic", fantasticCount,
            charts.ColorUtil.fromDartColor(const Color(0xffa49eff))),
      ];
    }
  }
}

class FeelCount {
  final String title;
  final double count;
  final charts.Color color;

  FeelCount(this.title, this.count, this.color);

  @override
  String toString() {
    return '\nFeelCount{title: $title, count: $count}';
  }
}