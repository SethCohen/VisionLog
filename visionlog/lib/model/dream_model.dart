import 'dart:async';
import 'package:sqflite/sqflite.dart';

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

  Future<void> deleteAllDreams() async {
    final db = await DBUtils.init();
    await db.delete('dream_items');
  }

  Future<List<Dream>> getAllDreams() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('dream_items');
    List<Dream> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Dream.fromMap(maps[i]));
      }
    }
    return result;
  }
}
