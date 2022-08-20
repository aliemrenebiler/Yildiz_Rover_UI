import 'dart:convert';
import 'package:http/http.dart';

import 'models.dart';
import '../backend/variables.dart';

getData(String url) async {
  var uri = Uri.parse(url);
  Response response;
  try {
    response = await get(uri);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      currentData = Data.fromJson(jsonData);
      if (currentData.battery.id != nullData) {
        batteryController.add(jsonData['battery']);
      }
      if (currentData.camera.id != nullData) {
        WebCamera newCamera = currentData.camera;
        webCameraController.add(newCamera);
      }
      statusController.add(currentData.status.id);
      if (currentData.atmosphere.id != nullData) {
        atmosphereController.add(jsonData['atmosphere']);
      }
      if (currentData.soil.id != nullData) {
        Soil newSoil = currentData.soil;
        saveSoilData(newSoil, newSoil.id);
        soilController.add(jsonData['soil']);
      }
      if (currentData.location.id != nullData) {
        locationController.add(jsonData['location']);
      }
      if (currentData.gas.id != nullData) {
        Gas newGas = currentData.gas;
        newGas.time = DateTime.now();
        saveGasData(newGas, gasGraphArchive, newGas.id);
        someGasController.add(jsonData['gas']);
        gasController.add(newGas);
      }
      if (currentData.npk.id != nullData) {
        NPK newNPK = currentData.npk;
        newNPK.time = DateTime.now();
        saveNPKData(newNPK, npkGraphArchive, newNPK.id);
        npkController.add(newNPK);
      }
      if (currentData.spectro1.id != nullData) {
        Spectro1 newSpectro = currentData.spectro1;
        saveSpectro1Data(newSpectro, spectroGraph1Archive, newSpectro.id);
        spectro1Controller.add(newSpectro);
      }
    } else {
      currentData = emptyData;
    }
  } catch (err) {
    currentData = emptyData;
  }
}

getCameraIDs(String cameras) {
  List<int> cameraIDs = [];
  int end = cameras.length - 1;
  if (cameras[0] == "[" && cameras[end] == "]") {
    List<String> temp = cameras.substring(1, end).split(",");
    for (int i = 0; i < temp.length; i++) {
      cameraIDs.add(int.parse(temp[i]));
    }
  }
  return cameraIDs;
}

saveSoilData(Soil newSoil, int id) {
  soilPHGraphArchive[id - 1].add(newSoil.ph);
  soilTempGraphArchive[id - 1].add(newSoil.temperature);
}

saveGasData(Gas newGas, List<Gas> graph, int id) {
  graph.add(newGas);
}

saveNPKData(NPK newNPK, List<List<NPK>> graph, int id) {
  graph[id - 1].add(newNPK);
}

saveSpectro1Data(Spectro1 newSpectro, List<List<Spectro1>> graph, int id) {
  graph[id - 1].add(newSpectro);
}

double countAverage(List<double> data) {
  return data.reduce((value, element) => value + element) / data.length;
}
