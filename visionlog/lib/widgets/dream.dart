import 'package:cloud_firestore/cloud_firestore.dart';

class Dream {
  String? title;
  String? message;
  String? feel;
  DocumentReference? reference;


  Dream.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.title = map['title'];
    this.message = map['message'];
    this.feel = map['feel'];
  }
}