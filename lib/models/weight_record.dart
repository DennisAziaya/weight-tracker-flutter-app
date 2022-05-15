import 'package:flutter/foundation.dart';

class WeightRecord {
  String? id;
  String weight;
  DateTime entryDate;
  //bool isDeleted;

  WeightRecord({this.id, required this.weight, required this.entryDate});

  //factory WeightRecord.fromJson(Map<String, dynamic> json) {
  // factory WeightRecord.fromJson(Map<String, dynamic> json) {
  // json.forEach((recordId, recordData) {
  //   WeightRecord(
  //       id: recordId,
  //       weight: recordData["weight"],
  //       entryDate: recordData["createdAt"]);
  // });

  // return WeightRecord(id: json.forEach((recordId, recordData) {
  //       return id: recordId
  // }), weight: json['name']['weight'], entryDate: json['name']['createdAt'] );

  // return WeightRecord(
  //   //id: json['name'],
  //   weight: json['weight'],
  //   entryDate: json['createdAt'],
  // );
  // }

  // void toggleDeleteRecord() {
  //   isDeleted = !isDeleted;
  //   print("Weight $weight Deleted");
  // }
}
