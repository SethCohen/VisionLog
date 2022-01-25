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
    title = map['title'];
    message = map['message'];
    feel = map['feel'];
    datetime = map['timestamp'].toDate();
    isLucid = map['is_lucid'];
    isNightmare = map['is_nightmare'];
    isRecurring = map['is_recurring'];
    isContinuous = map['is_continuous'];
  }

  @override
  String toString() {
    return '\nDream: {title: $title, message: $message, feel: $feel, datetime: $datetime, isLucid: $isLucid, isNightmare: $isNightmare, isRecurring: $isRecurring, isContinuous: $isContinuous}';
  }
}