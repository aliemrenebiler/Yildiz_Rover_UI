import '../classes.dart';

// DATA PAGE DATA
List<Gas> gasChartData = [];

// ARCHIVE PAGE DATA
int sampleAmount = 0;
List<Soil> soilSamples = [];
List<SoilWeight> weightSamples = [];
List<Voltage> savedVoltages = [];
Gas avrgGas = Gas(
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
  no2: 0,
);
Gas gasAmount = Gas(
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
  no2: 0,
);

// FUNCTIONS
saveGasData(Map<String, dynamic> newData) {
  Gas newGas = Gas.fromJson(newData);
  newGas.time = DateTime.now();
  gasChartData.add(newGas);

  if (gasChartData.length > 10) {
    gasChartData.removeAt(0);
  }

  if (newGas.c3h8 > 0) {
    avrgGas.c3h8 =
        ((avrgGas.c3h8 * gasAmount.c3h8) + newGas.c3h8) / (gasAmount.c3h8 + 1);
    gasAmount.c3h8 = gasAmount.c3h8 + 1;
  }
  if (newGas.ch4 > 0) {
    avrgGas.ch4 =
        ((avrgGas.ch4 * gasAmount.ch4) + newGas.ch4) / (gasAmount.ch4 + 1);
    gasAmount.ch4 = gasAmount.ch4 + 1;
  }
  if (newGas.co > 0) {
    avrgGas.co = ((avrgGas.co * gasAmount.co) + newGas.co) / (gasAmount.co + 1);
    gasAmount.co = gasAmount.co + 1;
  }
  if (newGas.co2 > 0) {
    avrgGas.co2 =
        ((avrgGas.co2 * gasAmount.co2) + newGas.co2) / (gasAmount.co2 + 1);
    gasAmount.co2 = gasAmount.co2 + 1;
  }
  if (newGas.ethanol > 0) {
    avrgGas.ethanol = ((avrgGas.ethanol * gasAmount.ethanol) + newGas.ethanol) /
        (gasAmount.ethanol + 1);
    gasAmount.ethanol = gasAmount.ethanol + 1;
  }
  if (newGas.h2 > 0) {
    avrgGas.h2 = ((avrgGas.h2 * gasAmount.h2) + newGas.h2) / (gasAmount.h2 + 1);
    gasAmount.h2 = gasAmount.h2 + 1;
  }
  if (newGas.h2s > 0) {
    avrgGas.h2s =
        ((avrgGas.h2s * gasAmount.h2s) + newGas.h2s) / (gasAmount.h2s + 1);
    gasAmount.h2s = gasAmount.h2s + 1;
  }
  if (newGas.nh3 > 0) {
    avrgGas.nh3 =
        ((avrgGas.nh3 * gasAmount.nh3) + newGas.nh3) / (gasAmount.nh3 + 1);
    gasAmount.nh3 = gasAmount.nh3 + 1;
  }
  if (newGas.no > 0) {
    avrgGas.no = ((avrgGas.no * gasAmount.no) + newGas.no) / (gasAmount.no + 1);
    gasAmount.no = gasAmount.no + 1;
  }
  if (newGas.no2 > 0) {
    avrgGas.no2 =
        ((avrgGas.no2 * gasAmount.no2) + newGas.no2) / (gasAmount.no2 + 1);
    gasAmount.no2 = gasAmount.no2 + 1;
  }
  gasAmount.id += 1;
  avrgGas.id += 1;
}

saveSoilData(Map<String, dynamic> newData) {
  Soil newSoil = Soil.fromJson(newData);
  newSoil.id = soilSamples.length + 1;
  newSoil.date = DateTime.now();
  soilSamples.add(newSoil);
}

saveWeightData(Map<String, dynamic> newData) {
  SoilWeight newWeight = SoilWeight.fromJson(newData);
  if (newWeight.weights.isNotEmpty) {
    newWeight.id = weightSamples.length + 1;
    newWeight.date = DateTime.now();
    weightSamples.add(newWeight);
  }
}

saveVoltageData(Map<String, dynamic> newData) {
  Voltage newVoltage = Voltage.fromJson(newData);
  newVoltage.id = savedVoltages.length + 1;
  newVoltage.date = DateTime.now();
  savedVoltages.add(newVoltage);
}
