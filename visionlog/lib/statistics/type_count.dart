import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TypeCount {
  final String type;
  final double count;
  final charts.Color color;

  TypeCount(this.type, this.count, this.color);

  String toString() {
    return '\nTypeCount{type: $type, count: $count}';
  }
}