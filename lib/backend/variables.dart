import 'dart:async';

import 'models.dart';

// SETTINGS
// These should be set before start!
String connectedIP = '192.168.1.16';
String dataHttpPort = '3000';

// GENERAL
Data emptyData = Data(
  battery: Battery(id: 0, precent: 0),
  camera: WebCamera(id: 0, cameras: "{}"),
  status: Status(id: 0),
  atmosphere: Atmosphere(id: 0, temperature: 0, moisture: 0, pressure: 0),
  soil: Soil(id: 0, temperature: 0, ph: 0),
  location: Location(id: 0, x: 0, y: 0, z: 0),
  gas: Gas(
      id: 0,
      c3h8: 0,
      c4h10: 0,
      ch4: 0,
      co: 0,
      co2: 0,
      ethanol: 0,
      h2: 0,
      h2s: 0,
      nh3: 0,
      no: 0,
      no2: 0),
  spectro1: Spectro1(id: 0, wavelength: 0, reflectance: 0),
  spectro2: Spectro2(id: 0, wavelength: 0, transmittance: 0),
  npk: NPK(id: 0, n: 0, p: 0, k: 0),
);
Data currentData = emptyData;
Map<String, dynamic> jsonData = emptyData.toJson();

// CONTROLLERS
StreamController<Map<String, dynamic>> batteryController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> batteryStream = batteryController.stream;

StreamController<WebCamera> webCameraController =
    StreamController<WebCamera>.broadcast();
Stream<WebCamera> webCameraStream = webCameraController.stream;

StreamController<int> statusController = StreamController<int>.broadcast();
Stream<int> statusStream = statusController.stream;

StreamController<Map<String, dynamic>> atmosphereController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> atmosphereStream = atmosphereController.stream;

StreamController<Map<String, dynamic>> someGasController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> someGasStream = someGasController.stream;

StreamController<Map<String, dynamic>> soilController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> soilStream = soilController.stream;

StreamController<Map<String, dynamic>> locationController =
    StreamController<Map<String, dynamic>>.broadcast();
Stream<Map<String, dynamic>> locationStream = locationController.stream;

StreamController<Gas> gasController = StreamController<Gas>.broadcast();
Stream<Gas> gasStream = gasController.stream;

StreamController<NPK> npkController = StreamController<NPK>.broadcast();
Stream<NPK> npkStream = npkController.stream;

StreamController<Spectro1> spectro1Controller =
    StreamController<Spectro1>.broadcast();
Stream<Spectro1> spectro1Stream = spectro1Controller.stream;

StreamController<Spectro2> spectro2Controller =
    StreamController<Spectro2>.broadcast();
Stream<Spectro2> spectro2Stream = spectro2Controller.stream;

// NULL DATA CHECK
int nullData = 0; // used for null data check

// === GRAPH VARIABLES ===
int graphLayoutIndex = 0;

// GRAPH DATA FOR BUTTONS
List<String> dataGraphTitles = [
  'Multiple Gas',
  'VIS/NIR Ref. Spec.',
];
int dataGraphAmount = dataGraphTitles.length;

List<String> archiveGraphTitles = [
  'Multiple Gas',
  'NPK Graph #1',
  'VIS/NIR Ref. Spec. #1',
  'VIS Spectrometer #1',
  'NPK Graph #2',
  'VIS/NIR Ref. Spec. #2',
  'VIS Spectrometer #2',
  'NPK Graph #3',
  'VIS/NIR Ref. Spec. #3',
  'VIS Spectrometer #3',
  'NPK Graph #4',
  'VIS/NIR Ref. Spec. #4',
  'VIS Spectrometer #4',
];
int archiveGraphAmount = archiveGraphTitles.length;

// EMPTY GRAPH DATA
List<Gas> emptyGasGraph = [];
List<Spectro1> emptySpectro1Graph = [];
List<Spectro2> emptySpectro2Graph = [];
List<NPK> emptyNPKGraph = [];

// ARCHIVE GRAPHES
List<Gas> gasGraphArchive = [];
List<List<NPK>> npkGraphArchive = [[], [], [], []];
List<List<Spectro1>> spectroGraph1Archive = [[], [], [], []];
List<List<Spectro2>> spectroGraph2Archive = [[], [], [], []];
List<List<double>> soilTempGraphArchive = [[], [], [], []];
List<List<double>> soilPHGraphArchive = [[], [], [], []];
