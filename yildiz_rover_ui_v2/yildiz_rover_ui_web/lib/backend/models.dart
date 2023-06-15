class Data {
  Battery battery;
  WebCamera camera;
  Status status;
  Atmosphere atmosphere;
  Soil soil;
  Location location;
  Gas gas;
  Spectro1 spectro1;
  Spectro2 spectro2;
  NPK npk;

  Data({
    required this.battery,
    required this.camera,
    required this.status,
    required this.atmosphere,
    required this.soil,
    required this.location,
    required this.gas,
    required this.spectro1,
    required this.spectro2,
    required this.npk,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        battery: Battery.fromJson(json["battery"]),
        camera: WebCamera.fromJson(json["camera"]),
        status: Status.fromJson(json["status"]),
        atmosphere: Atmosphere.fromJson(json["atmosphere"]),
        soil: Soil.fromJson(json["soil"]),
        location: Location.fromJson(json["location"]),
        gas: Gas.fromJson(json["gas"]),
        npk: NPK.fromJson(json["npk"]),
        spectro1: Spectro1.fromJson(json["spectro1"]),
        spectro2: Spectro2.fromJson(json["spectro2"]),
      );

  Map<String, dynamic> toJson() => {
        "battery": battery.toJson(),
        "camera": camera.toJson(),
        "status": status.toJson(),
        "atmosphere": atmosphere.toJson(),
        "soil": soil.toJson(),
        "location": location.toJson(),
        "gas": gas.toJson(),
        "npk": npk.toJson(),
        "spectro1": spectro1.toJson(),
        "spectro2": spectro2.toJson(),
      };
}

class Battery {
  int id;
  int precent;

  Battery({
    required this.id,
    required this.precent,
  });

  factory Battery.fromJson(Map<String, dynamic> json) => Battery(
        id: json["id"],
        precent: json["precent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "precent": precent,
      };
}

class WebCamera {
  int id;
  String cameras;

  WebCamera({
    required this.id,
    required this.cameras,
  });

  factory WebCamera.fromJson(Map<String, dynamic> json) => WebCamera(
        id: json["id"],
        cameras: json["cameras"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cameras": cameras,
      };
}

class Status {
  int id;

  Status({
    required this.id,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Atmosphere {
  int id;
  double temperature;
  double moisture;
  double pressure;

  Atmosphere({
    required this.id,
    required this.temperature,
    required this.moisture,
    required this.pressure,
  });

  factory Atmosphere.fromJson(Map<String, dynamic> json) => Atmosphere(
        id: json["id"],
        temperature: json["temperature"],
        moisture: json["moisture"],
        pressure: json["pressure"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "temperature": temperature,
        "moisture": moisture,
        "pressure": pressure,
      };
}

class Soil {
  int id;
  double temperature;
  double ph;

  Soil({
    required this.id,
    required this.temperature,
    required this.ph,
  });

  factory Soil.fromJson(Map<String, dynamic> json) => Soil(
        id: json["id"],
        temperature: json["temperature"],
        ph: json["ph"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "temperature": temperature,
        "ph": ph,
      };
}

class Location {
  int id;
  double x;
  double y;
  double z;

  Location({
    required this.id,
    required this.x,
    required this.y,
    required this.z,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        x: json["x"],
        y: json["y"],
        z: json["z"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "x": x,
        "y": y,
        "z": z,
      };
}

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

class NPK {
  int id;
  DateTime? time;
  double n;
  double p;
  double k;
  NPK({
    required this.id,
    this.time,
    required this.n,
    required this.p,
    required this.k,
  });

  factory NPK.fromJson(Map<String, dynamic> json) => NPK(
        id: json["id"],
        n: json["n"],
        p: json["p"],
        k: json["k"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ppm_c3h8": n,
        "ppm_c4h10": p,
        "ppm_ch4": k,
      };
}

class Spectro1 {
  int id;
  double wavelength;
  double reflectance;
  Spectro1({
    required this.id,
    required this.wavelength,
    required this.reflectance,
  });

  factory Spectro1.fromJson(Map<String, dynamic> json) => Spectro1(
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

class Spectro2 {
  int id;
  double wavelength;
  double transmittance;
  Spectro2({
    required this.id,
    required this.wavelength,
    required this.transmittance,
  });

  factory Spectro2.fromJson(Map<String, dynamic> json) => Spectro2(
        id: json["id"],
        wavelength: json["wavelength"],
        transmittance: json["transmittance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wavelength": wavelength,
        "transmittance": transmittance,
      };
}

class SoilTempPHData {
  final String title;
  final double? pH;
  final double? temperature;
  SoilTempPHData({
    required this.title,
    this.temperature,
    this.pH,
  });
}
