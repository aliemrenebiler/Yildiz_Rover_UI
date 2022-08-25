import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'saving_methods.dart';

// SETTINGS
String connectedIP = 'localhost';
String dataHttpPort = '3000';

// CONTROLLERS
StreamController<Map<String, dynamic>> batteryController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> batteryStream = batteryController.stream;

StreamController<Map<String, dynamic>> webCameraController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> webCameraStream = webCameraController.stream;

StreamController<Map<String, dynamic>> statusController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> statusStream = statusController.stream;

StreamController<Map<String, dynamic>> atmosphereController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> atmosphereStream = atmosphereController.stream;

StreamController<Map<String, dynamic>> soilController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> soilStream = soilController.stream;

StreamController<Map<String, dynamic>> gasController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> gasStream = gasController.stream;

StreamController<Map<String, dynamic>> voltageController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> voltageStream = voltageController.stream;

// JSON DATA
Map<String, dynamic> jsonData = {};

// FUNCTIONS
getData(String url) async {
  var uri = Uri.parse(url);
  Response response;
  try {
    response = await get(uri);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      int nullData = 0;

      if (jsonData['battery']['id'] != nullData) {
        batteryController.add(jsonData['battery']);
      }
      if (jsonData['camera']['id'] != nullData) {
        webCameraController.add(jsonData['camera']);
      }
      if (jsonData['status']['id'] != nullData) {
        statusController.add(jsonData['status']);
      }
      if (jsonData['atmosphere']['id'] != nullData) {
        atmosphereController.add(jsonData['atmosphere']);
      }
      if (jsonData['soil']['id'] != nullData) {
        saveSoilData(jsonData['soil']);
        soilController.add(jsonData['soil']);
      }
      if (jsonData['gas']['id'] != nullData) {
        saveGasData(jsonData['gas']);
        gasController.add(jsonData['gas']);
      }
      voltageController.add(jsonData['others']);
    }
  } catch (err) {
    return;
  }
}
