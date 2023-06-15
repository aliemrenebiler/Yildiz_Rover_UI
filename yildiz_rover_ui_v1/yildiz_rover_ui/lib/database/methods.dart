import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:roslib/roslib.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'variables.dart';

// FIND NETWORK IP
Future<String> findNetworkIp() async {
  // ATÖLYE: 192.168.28.101
  // EV: 192.168.1.11
  final NetworkInfo myInfo = NetworkInfo();
  var networkIp = await myInfo.getWifiIP();
  var rosUrl = 'ws://$networkIp:9090';
  return rosUrl;
}

// SUBSCRIBE - UNSUBSCRIBE
void subscribeDataPage() async {
  // Unsubscribe from cameras
  // await camera.unsubscribe();
  // Subscribe to datas
  await atmosphere.subscribe();
  await soil.subscribe();
  await location.subscribe();
  await battery.subscribe();
  await gasgraph.subscribe();
  await npkgraph.subscribe();
  await spectrograph.subscribe();
  print('SUBSCRIBED TO DATAS');
}

void subscribeCameraPage() async {
  // Unsubscribe from datas
  await atmosphere.unsubscribe();
  await soil.unsubscribe();
  await location.unsubscribe();
  await battery.unsubscribe();
  await gasgraph.unsubscribe();
  await npkgraph.unsubscribe();
  await spectrograph.unsubscribe();
  // Subscribe to cameras
  // await camera.subscribe();
  print('SUBSCRIBED TO CAMERAS');
}

void unsubscribeFromAll() async {
  await atmosphere.unsubscribe();
  await soil.unsubscribe();
  await location.unsubscribe();
  await battery.unsubscribe();
  await gasgraph.unsubscribe();
  await npkgraph.unsubscribe();
  await spectrograph.unsubscribe();
  await camera.unsubscribe();
  print('UNSUBSCRIBED FROM ALL TOPICS');
}

// PUBLISH DATA
void publishData(String dataName, Topic topicName, String msgText) async {
  var msg = {dataName: msgText};
  await topicName.publish(msg);
  print('PUBLISHED');
}

void publishLocation() async {
  publishData('data', altilatti,
      textController1.text); // THIS WILL BE CHANGED!!! <======
  publishData('data', altilatti,
      textController2.text); // THIS WILL BE CHANGED!!! <======
  altitudeController.add(textController1.text);
  lattitudeController.add(textController2.text);
  textController1.clear();
  textController2.clear();
}

// IMAGE PROCESSING
Uint8List bytesToImage(String byteData) {
  List<int> byteList = byteData.codeUnits;
  Uint8List uint8ByteList = Uint8List.fromList(byteList);
  return uint8ByteList;
}

// IN PROGRESS...
void runCommand() async {
  // await Process.run('google-chrome', []); // BU ÇALIŞIYOR
  var process = await Process.run('pwd', []);
  var stdout = process.stdout;
  print('output: $stdout');

  var process2 = await Process.start('python', ['~/debug.py']);
  process2.stdout.transform(utf8.decoder).forEach(print);
  var exitCode = await process2.exitCode;
  print('exit code: $exitCode');
}
