import '../classes.dart';

// DATA PAGE DATA
List<Gas> gasChartData = [];
List<Spectro> spectroChartData = [];

// ARCHIVE PAGE DATA
int sampleAmount = 0;
List<SoilSample> soilSamples = [
  SoilSample(
    id: -5,
    soil: Soil(id: 0, temperature: 1, n: 2, p: 3, k: 4),
    spectro: spectroChartData,
  ),
];
Gas avrgGas = Gas(
  id: 0,
  c3h8: 6,
  c4h10: 0,
  ch4: 0,
  co: 0,
  co2: 0,
  ethanol: 0,
  h2: 0,
  h2s: 6,
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

  avrgGas.id += 1;
  avrgGas.c3h8 += (avrgGas.c3h8 * (avrgGas.id - 1) + newGas.c3h8) / avrgGas.id;
  avrgGas.c4h10 +=
      (avrgGas.c4h10 * (avrgGas.id - 1) + newGas.c4h10) / avrgGas.id;
  avrgGas.ch4 += (avrgGas.ch4 * (avrgGas.id - 1) + newGas.ch4) / avrgGas.id;
  avrgGas.co += (avrgGas.co * (avrgGas.id - 1) + newGas.co) / avrgGas.id;
  avrgGas.co2 += (avrgGas.co2 * (avrgGas.id - 1) + newGas.co2) / avrgGas.id;
  avrgGas.ethanol +=
      (avrgGas.ethanol * (avrgGas.id - 1) + newGas.ethanol) / avrgGas.id;
  avrgGas.h2 += (avrgGas.h2 * (avrgGas.id - 1) + newGas.h2) / avrgGas.id;
  avrgGas.h2s += (avrgGas.h2s * (avrgGas.id - 1) + newGas.h2s) / avrgGas.id;
  avrgGas.nh3 += (avrgGas.nh3 * (avrgGas.id - 1) + newGas.nh3) / avrgGas.id;
  avrgGas.no += (avrgGas.no * (avrgGas.id - 1) + newGas.no) / avrgGas.id;
  avrgGas.no2 += (avrgGas.no2 * (avrgGas.id - 1) + newGas.no2) / avrgGas.id;
}

saveSoilData(Map<String, dynamic> newData) {
  Soil newSoil = Soil.fromJson(newData);
  sampleAmount += 1;
  SoilSample newSample =
      SoilSample(id: sampleAmount, soil: newSoil, spectro: spectroChartData);
  soilSamples.add(newSample);
}

// WILL BE CHANGED <===========================================================================0
saveSpectroData() {}
