class Gas {
  int id;
  DateTime? time;
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
  Gas({
    required this.id,
    this.time,
    required this.c3h8,
    required this.c4h10,
    required this.ch4,
    required this.co,
    required this.co2,
    required this.ethanol,
    required this.h2,
    required this.h2s,
    required this.nh3,
    required this.no,
    required this.no2,
  });

  factory Gas.fromJson(Map<String, dynamic> json) => Gas(
        id: json["id"],
        c3h8: json["ppm_c3h8"],
        c4h10: json["ppm_c4h10"],
        ch4: json["ppm_ch4"],
        co: json["ppm_co"],
        co2: json["ppm_co2"],
        ethanol: json["ppm_ethanol"],
        h2: json["ppm_h2"],
        h2s: json["ppm_h2s"],
        nh3: json["ppm_nh3"],
        no: json["ppm_no"],
        no2: json["ppm_no2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ppm_c3h8": c3h8,
        "ppm_c4h10": c4h10,
        "ppm_ch4": ch4,
        "ppm_co": co,
        "ppm_co2": co2,
        "ppm_ethanol": ethanol,
        "ppm_h2": h2,
        "ppm_h2s": h2s,
        "ppm_nh3": nh3,
        "ppm_no": no,
        "ppm_no2": no2,
      };
}

class Spectro {
  int id;
  double wavelength;
  double reflectance;
  Spectro({
    required this.id,
    required this.wavelength,
    required this.reflectance,
  });

  factory Spectro.fromJson(Map<String, dynamic> json) => Spectro(
        id: json["id"],
        wavelength: json["wavelength"],
        reflectance: json["reflectance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wavelength": wavelength,
        "reflectance": reflectance,
      };
}

class Soil {
  int id;
  double temperature;
  double n;
  double p;
  double k;
  DateTime? date;
  Soil({
    required this.id,
    required this.temperature,
    required this.n,
    required this.p,
    required this.k,
    this.date,
  });

  factory Soil.fromJson(Map<String, dynamic> json) => Soil(
        id: json["id"],
        temperature: json["temperature"],
        n: json["n"],
        p: json["p"],
        k: json["k"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "temperature": temperature,
        "n": n,
        "p": p,
        "k": k,
      };
}

class SoilWeight {
  int? id;
  DateTime? date;
  List<double> weights;
  SoilWeight({
    this.id,
    this.date,
    required this.weights,
  });

  factory SoilWeight.fromJson(Map<String, dynamic> json) => SoilWeight(
        weights: json["soil_weights"],
      );

  Map<String, dynamic> toJson() => {
        "soil_weights": weights,
      };
}

class Voltage {
  int? id;
  DateTime? date;
  double voltage;
  Voltage({
    this.id,
    this.date,
    required this.voltage,
  });

  factory Voltage.fromJson(Map<String, dynamic> json) => Voltage(
        voltage: json["panel_voltage"],
      );

  Map<String, dynamic> toJson() => {
        "panel_voltage": voltage,
      };
}
