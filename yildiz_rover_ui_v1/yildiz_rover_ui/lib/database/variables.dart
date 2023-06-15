import 'dart:async';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:roslib/roslib.dart';

// CLASSES
class MultiGasData {
  double time;
  double c3h8;
  double c4h10;
  double ch4;
  double co;
  double co2;
  double ethanol;
  double h2;
  double h2s;
  double nh3;
  double no;
  double no2;
  MultiGasData(
    this.time,
    this.c3h8,
    this.c4h10,
    this.ch4,
    this.co,
    this.co2,
    this.ethanol,
    this.h2,
    this.h2s,
    this.nh3,
    this.no,
    this.no2,
  );
}

class NPKData {
  final double time;
  final double n;
  final double p;
  final double k;
  NPKData(this.time, this.n, this.p, this.k);
}

class SpectroData {
  final double wavelength;
  final double transmittance;
  SpectroData(this.wavelength, this.transmittance);
}

class SoilTempData {
  final String time;
  final double temperature;
  SoilTempData(this.time, this.temperature);
}

class SoilPHData {
  final String time;
  final double pH;
  SoilPHData(this.time, this.pH);
}

// GENERAL, ROS AND TOPICS
int currentScreenIndex = 0;
String? rosUrl;
Ros ros = Ros(url: rosUrl);
Topic atmosphere = Topic(
  ros: ros,
  name: '/atmosphere',
  type: "ui_messages/atmosphere",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic soil = Topic(
  ros: ros,
  name: '/soil',
  type: "ui_messages/soil",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic location = Topic(
  ros: ros,
  name: '/location',
  type: "ui_messages/location",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic battery = Topic(
  ros: ros,
  name: '/battery',
  type: "ui_messages/battery",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic gasgraph = Topic(
  ros: ros,
  name: '/graph_gas',
  type: "ui_messages/graph_gas",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic npkgraph = Topic(
  ros: ros,
  name: '/graph_npk',
  type: "ui_messages/graph_npk",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic spectrograph = Topic(
  ros: ros,
  name: '/graph_spectro',
  type: "ui_messages/graph_spectro",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);
Topic altilatti = Topic(
  ros: ros,
  name: '/altilatti',
  type: "std_msgs/String",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);

Topic camera = Topic(
  ros: ros,
  name: '/camera/image_raw',
  type: "sensor_msgs/Image",
  reconnectOnClose: true,
  queueLength: 10,
  queueSize: 10,
);

// DATA SCREEN VARIABLES
StreamController<bool> hoverGasGraphController =
    StreamController<bool>.broadcast();
Stream<bool> hoverGasGraphStream = hoverGasGraphController.stream;

StreamController<String> altitudeController =
    StreamController<String>.broadcast();
Stream<String> altitudeStream = altitudeController.stream;
StreamController<String> lattitudeController =
    StreamController<String>.broadcast();
Stream<String> lattitudeStream = lattitudeController.stream;
StreamController<String> commandController =
    StreamController<String>.broadcast();
Stream<String> commandStream = commandController.stream;

var textController1 = TextEditingController();
var textController2 = TextEditingController();
var textController3 = TextEditingController();

List<MultiGasData> multiGasGraphData = [
  /*
  MultiGasData(
      1, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 9000, 8000),
  MultiGasData(
      2, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 9000, 8000, 7000),
  MultiGasData(
      3, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 9000, 8000, 7000, 6000),
  MultiGasData(
      4, 5000, 6000, 7000, 8000, 9000, 10000, 9000, 8000, 7000, 6000, 5000),
  MultiGasData(
      5, 6000, 7000, 8000, 9000, 10000, 9000, 8000, 7000, 6000, 5000, 4000),
  */
];
List<MultiGasData> emptyGasData = [];
List<NPKData> npkGraphData = [
  NPKData(1, 100, 200, 300),
  NPKData(2, 200, 300, 400),
  NPKData(3, 300, 400, 500),
  NPKData(4, 400, 500, 600),
  NPKData(5, 500, 600, 700),
];
List<SpectroData> spectroGraphData = [
  SpectroData(405, 75),
  SpectroData(410, 85),
  SpectroData(415, 80),
  SpectroData(430, 96),
  SpectroData(440, 35),
  SpectroData(450, 10),
  SpectroData(455, 5),
  SpectroData(480, 2),
  SpectroData(500, 0),
  SpectroData(520, 3),
  SpectroData(550, 10),
  SpectroData(580, 23),
  SpectroData(600, 16),
  SpectroData(620, 32),
  SpectroData(640, 20),
  SpectroData(650, 30),
  SpectroData(665, 75),
  SpectroData(680, 25),
  SpectroData(695, 5),
];

// CAMERA SCREEN VARIABLES
int cameraLayoutIndex = 0;

// ARCHIVE SCREEN VARIABLES
int graphLayoutIndex = 0;

List<String> graphTitles = [
  'NPK Graph #1',
  'NPK Graph #2',
  'NPK Graph #3',
  'NPK Graph #4',
  'Spec. Graph #1',
  'Spec. Graph #2',
  'Spec. Graph #3',
  'Spec. Graph #4',
  'Spec. Graph #5',
  'Spec. Graph #6',
  'Spec. Graph #7',
  'Spec. Graph #8',
  'Soil Temp. Graph',
  'Soil pH Graph',
];

List allGraphs = [
  savedNPKGraph1Data,
  savedNPKGraph2Data,
  savedNPKGraph3Data,
  savedNPKGraph4Data,
  savedSpectroGraph1Data,
  savedSpectroGraph2Data,
  savedSpectroGraph3Data,
  savedSpectroGraph4Data,
  savedSpectroGraph5Data,
  savedSpectroGraph6Data,
  savedSpectroGraph7Data,
  savedSpectroGraph8Data,
  savedSoilTempData,
  savedSoilPHData,
];

List<NPKData> savedNPKGraph1Data = [
  NPKData(1, 100, 200, 300),
  NPKData(2, 200, 300, 400),
  NPKData(3, 300, 400, 500),
  NPKData(4, 400, 500, 600),
  NPKData(5, 500, 600, 700),
];

List<NPKData> savedNPKGraph2Data = [
  NPKData(1, 100, 200, 300),
  NPKData(2, 200, 300, 400),
  NPKData(3, 300, 400, 500),
  NPKData(4, 400, 500, 600),
  NPKData(5, 500, 600, 700),
];

List<NPKData> savedNPKGraph3Data = [
  NPKData(1, 100, 200, 300),
  NPKData(2, 200, 300, 400),
  NPKData(3, 300, 400, 500),
  NPKData(4, 400, 500, 600),
  NPKData(5, 500, 600, 700),
];

List<NPKData> savedNPKGraph4Data = [
  NPKData(1, 100, 200, 300),
  NPKData(2, 200, 300, 400),
  NPKData(3, 300, 400, 500),
  NPKData(4, 400, 500, 600),
  NPKData(5, 500, 600, 700),
];

List<SpectroData> savedSpectroGraph1Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph2Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph3Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph4Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph5Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph6Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph7Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SpectroData> savedSpectroGraph8Data = [
  SpectroData(300, 30),
  SpectroData(400, 45),
  SpectroData(500, 78),
  SpectroData(600, 27),
  SpectroData(700, 34),
];

List<SoilTempData> savedSoilTempData = [
  SoilTempData('Sample 1', -150),
  SoilTempData('Sample 2', 45),
  SoilTempData('Sample 3', 78),
  SoilTempData('Sample 4', 125),
];

List<SoilPHData> savedSoilPHData = [
  SoilPHData('Sample 1', 0),
  SoilPHData('Sample 2', 7),
  SoilPHData('Sample 3', 4),
  SoilPHData('Sample 4', 13),
];

////////////////// DENEME TOPICLER
List<SpectroData> dumpSpectroData = [];
//////////////////
