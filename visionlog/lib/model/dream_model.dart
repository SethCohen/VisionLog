import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visionlog/statistics/mood_count.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:visionlog/statistics/type_count.dart';

import 'db_utils.dart';
import 'dream.dart';

class DreamModel {
  Future<int> insertDream(Dream dream) async {
    final db = await DBUtils.init();
    return db.insert(
      'dream_items',
      dream.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDream(Dream dream) async {
    final db = await DBUtils.init();
    await db.update(
      'dream_items',
      dream.toMap(),
      where: 'id = ?',
      whereArgs: [dream.id],
    );
  }

  Future<void> deleteDreamById(int id) async {
    final db = await DBUtils.init();
    await db.delete(
      'dream_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Dream>> getAllDreams() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps =
        await db.query('dream_items', orderBy: "datetime DESC");
    List<Dream> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Dream.fromMap(maps[i]));
      }
    }
    return result;
  }

  Future<List<MoodCount>> getDreamsMoodCount(String timerange) async {
    final db = await DBUtils.init();

    List<String> possibleMoods = [
      'terrible',
      'bad',
      'average',
      'okay',
      'fantastic'
    ];

    List<charts.Color> possibleMoodColours = [
      charts.ColorUtil.fromDartColor(Color(0xFF882255)),
      charts.ColorUtil.fromDartColor(Color(0xFFDDCC77)),
      charts.ColorUtil.fromDartColor(Color(0xFF88CCEE)),
      charts.ColorUtil.fromDartColor(Color(0xFF117733)),
      charts.ColorUtil.fromDartColor(Color(0xFF3A27A8))
    ];

    List<MoodCount> result = [];

    for (var i = 0; i < possibleMoods.length; i++) {
      String mood = possibleMoods[i];
      charts.Color color = possibleMoodColours[i];
      int count;
      if (timerange == 'All-time') {
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE moodFeel LIKE '$mood'"));
      } else if (timerange == 'Yearly') {
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE moodFeel LIKE '$mood' AND 'datetime' > date('now', '-12 month')"));
      } else if (timerange == 'Monthly') {
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE moodFeel LIKE '$mood' AND 'datetime' > date('now', '-1 month')"));
      } else if (timerange == 'Weekly') {
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE moodFeel LIKE '$mood' AND 'datetime' > date('now', '-7 day')"));
      }
      result.add(MoodCount(mood, count.toDouble(), color));
    }

    double sum = result.fold(0, (count, object) => count + object.count);

    result = result.map((e) => MoodCount(e.moodfeel, e.count/sum, e.color)).toList();
    print('\nlist' + result.toString());

    return result;
  }

  Future<List<TypeCount>> getDreamsTypeCount(String timerange) async {
    final db = await DBUtils.init();

    List<String> possibleTypes = [
      'lucid',
      'nightmare',
      'recurring',
      'continuous',
    ];

    List<charts.Color> possibleTypeColours = [
      charts.ColorUtil.fromDartColor(Color(0xFF882255)),
      charts.ColorUtil.fromDartColor(Color(0xFFDDCC77)),
      charts.ColorUtil.fromDartColor(Color(0xFF88CCEE)),
      charts.ColorUtil.fromDartColor(Color(0xFF117733)),
    ];

    List<TypeCount> result = [];

    for (var i = 0; i < possibleTypes.length; i++) {
      String type = possibleTypes[i];
      charts.Color color = possibleTypeColours[i];
      int count;
      if (timerange == 'All-time'){
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE $type LIKE 'true'"));
      } else if (timerange == 'Yearly'){
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE $type LIKE 'true' AND 'datetime' > date('now', '-12 month')"));
      } else if (timerange == 'Monthly'){
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE $type LIKE 'true' AND 'datetime' > date('now', '-1 month')"));
      } else if (timerange == 'Weekly'){
        count = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM dream_items WHERE $type LIKE 'true' AND 'datetime' > date('now', '-7 day')"));
      }
      result.add(TypeCount(type, count.toDouble(), color));
    }

    double sum = result.fold(0, (count, object) => count + object.count);

    result = result.map((e) => TypeCount(e.type, e.count/sum, e.color)).toList();
    
    return result;
  }

  getDreamsTypeCountYearly() {}
}
