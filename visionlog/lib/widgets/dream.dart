import 'package:cloud_firestore/cloud_firestore.dart';

class Dream {
  String? title;
  String? message;
  String feel = "average";
  DateTime datetime = DateTime.now();
  bool isLucid = false;
  bool isNightmare = false;
  bool isRecurring = false;
  bool isContinuous = false;
  DocumentReference? reference;


  Dream.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.title = map['title'];
    this.message = map['message'];
    this.feel = map['feel'];
    this.datetime = map['timestamp'].toDate();
    this.isLucid = map['is_lucid'];
    this.isNightmare = map['is_nightmare'];
    this.isRecurring = map['is_recurring'];
    this.isContinuous = map['is_continuous'];
  }

  @override
  String toString() {
    return '\nDream: {title: $title, message: $message, feel: $feel, datetime: $datetime, isLucid: $isLucid, isNightmare: $isNightmare, isRecurring: $isRecurring, isContinuous: $isContinuous}';
  }
}