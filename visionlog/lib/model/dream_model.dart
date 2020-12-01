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
    final List<Map<String, dynamic>> maps = await db.query('dream_items', orderBy: "datetime DESC");
    List<Dream> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Dream.fromMap(maps[i]));
      }
    }
    return result;
  }
}
