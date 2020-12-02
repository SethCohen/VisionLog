import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MoodCount {
  final String moodfeel;
  final double count;
  final charts.Color color;

  MoodCount(this.moodfeel, this.count, this.color);

  String toString() {
    return '\nMoodCount{moodfeel: $moodfeel, count: $count}';
  }
}