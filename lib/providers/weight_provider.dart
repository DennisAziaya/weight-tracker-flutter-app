import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/weight_record.dart';

class WeightDataProvider extends ChangeNotifier {
  String userAuthToken = '';

  WeightDataProvider(this.userAuthToken, this._records) {
    getRecords();
  }

  List<WeightRecord> _records = [];
  List<WeightRecord> get dataRecord => _records;

  // FETCH RECORDS
  Future<void> getRecords() async {
    try {
      final baseUrl = Uri.parse(
          'https://weight-tracker-be6c7-default-rtdb.firebaseio.com/records.json?auth=$userAuthToken');
      http.Response response = await http.get(baseUrl);

      final _allRecords = jsonDecode(response.body) as Map<String, dynamic>;
      final List<WeightRecord> fetchedRecords = [];
      _allRecords.forEach((recordId, recordData) {
        fetchedRecords.add(WeightRecord(
            id: recordId.toString(),
            weight: recordData['weight'],
            entryDate: DateTime.parse(recordData["createdAt"])));

        fetchedRecords.sort((a, b) {
          return (b.entryDate).compareTo((a.entryDate));
        });
      });

      _records = fetchedRecords;

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //ADD RECORD
  Future<void> addRecords(String weight, String createdAt) async {
    try {
      final baseUrl = Uri.parse(
          'https://weight-tracker-be6c7-default-rtdb.firebaseio.com/records.json?auth=$userAuthToken');
      http.Response response = await http.post(baseUrl,
          body: json.encode({"weight": weight, "createdAt": createdAt}));
      getRecords();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //UPDATE RECORD
  Future<void> updateRecords(String weight, String id) async {
    final baseUrl = Uri.parse(
        'https://weight-tracker-be6c7-default-rtdb.firebaseio.com/records/$id.json?auth=$userAuthToken');
    http.Response response =
        await http.patch(baseUrl, body: json.encode({"weight": weight}));
    getRecords();
    notifyListeners();
  }

  //REMOVE RECORD
  Future<void> removeRecord(String id) async {
    final baseUrl = Uri.parse(
        'https://weight-tracker-be6c7-default-rtdb.firebaseio.com/records/$id.json?auth=$userAuthToken');
    await http.delete(baseUrl);
    _records.removeWhere((record) => record.id == id);
    getRecords();
    notifyListeners();
  }
}
