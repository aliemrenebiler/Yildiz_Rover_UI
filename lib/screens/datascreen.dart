import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'generalwidgets.dart';
import '../backend/classes.dart';
import '../backend/methods/general_methods.dart';
import '../backend/methods/saving_methods.dart';
import '../backend/theme.dart';

int graphLayoutIndex = 0;

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    graphLayoutIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TopNavBar(),
            Expanded(
              child: SingleChildScrollView(
                primary: false,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const SoilBox(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const AtmospBox(),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.all(5),
                              child: AspectRatio(
                                aspectRatio: 1.5,
                                child: GasChart(
                                  title: 'Multiple Gas',
                                  stream: gasStream,
                                  graphData: gasChartData,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const StatusBox(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const SoilWeightBox(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const VoltageBox(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DATA BOX INNER WIDGET
class DataBox extends StatelessWidget {
  final String? name;
  final Stream<Object> stream;
  final String value;
  final int? index;
  const DataBox({
    Key? key,
    this.name,
    required this.stream,
    required this.value,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3),
      height: 40,
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (name != null)
              ? Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.all(3),
                    child: Text(
                      name!,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: roverFontM,
                      ),
                    ),
                  ),
                )
              : Container(),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(3),
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(roverRadiusM)),
              ),
              child: StreamBuilder<Object>(
                stream: stream,
                builder: (context, snapshot) {
                  String dataBoxText;
                  if (snapshot.hasData) {
                    Map<String, dynamic> newData =
                        snapshot.data as Map<String, dynamic>;
                    if (index != null) {
                      List newList = newData[value] as List;
                      if (newList.isEmpty) {
                        dataBoxText = '--';
                      } else {
                        if (double.tryParse(newList[index!].toString()) !=
                            null) {
                          dataBoxText = newList[index!].toStringAsFixed(3);
                        } else {
                          dataBoxText = newList[index!].toString();
                        }
                      }
                    } else {
                      if (double.tryParse(newData[value].toString()) != null) {
                        dataBoxText = newData[value].toStringAsFixed(3);
                      } else {
                        dataBoxText = newData[value].toString();
                      }
                    }
                  } else {
                    dataBoxText = '--';
                  }
                  return Text(
                    dataBoxText,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: roverFontM,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SaveDataButton extends StatelessWidget {
  final String name;
  final Stream<Object> stream;
  final String data;
  const SaveDataButton({
    Key? key,
    required this.name,
    required this.stream,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          int buttonColor;
          if (snapshot.hasData) {
            buttonColor = roverCoral;
          } else {
            buttonColor = roverDarkRed;
          }
          return InkWell(
            onTap: () {
              if (snapshot.hasData) {
                if (data == 'soil') {
                  saveSoilData(snapshot.data as Map<String, dynamic>);
                } else if (data == 'weights') {
                  saveWeightData(snapshot.data as Map<String, dynamic>);
                } else if (data == 'voltage') {
                  saveVoltageData(snapshot.data as Map<String, dynamic>);
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                color: Color(buttonColor),
                borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
              ),
              child: Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: roverFontM,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PitchRollBox extends StatelessWidget {
  final String? name;
  final Stream<Object> stream;
  final String value;
  final String image;
  final double maxValue;
  final double minValue;
  const PitchRollBox({
    Key? key,
    this.name,
    required this.stream,
    required this.value,
    required this.image,
    required this.maxValue,
    required this.minValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(3),
            height: 28,
            child: Text(
              name!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontM,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(roverRadiusM)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: AspectRatio(
                    aspectRatio: 2.3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    String dataBoxText;
                    double dataDoubleValue;
                    if (snapshot.hasData) {
                      Map<String, dynamic> newData =
                          snapshot.data! as Map<String, dynamic>;
                      dataDoubleValue = double.parse(newData[value].toString());
                      dataBoxText = dataDoubleValue.toString();
                    } else {
                      dataDoubleValue = maxValue / 2 + minValue / 2;
                      dataBoxText = '--';
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(roverLightGrey),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(roverRadiusM)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Container(
                                      height: 28,
                                      width: constraints.maxWidth *
                                          ((dataDoubleValue - minValue) /
                                              (maxValue - minValue)),
                                      decoration: BoxDecoration(
                                        color: roverGraphRed,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(roverRadiusM)),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(3),
                            child: Text(
                              dataBoxText,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// DATA BOXES
class StatusBox extends StatelessWidget {
  const StatusBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              'STATUS',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.all(5),
          //   child: DataBox(
          //     stream: statusStream,
          //     value: 'status_number',
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: PitchRollBox(
                    name: 'Pitch',
                    stream: statusStream,
                    value: 'pitch',
                    image: 'assets/sparkle_left.png',
                    maxValue: 1,
                    minValue: -1,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: PitchRollBox(
                    name: 'Roll',
                    stream: statusStream,
                    value: 'roll',
                    image: 'assets/sparkle_back.png',
                    maxValue: 1,
                    minValue: -1,
                  ),
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         margin: const EdgeInsets.all(5),
          //         child: DataBox(
          //           name: 'X Coord.',
          //           stream: statusStream,
          //           value: 'x',
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         margin: const EdgeInsets.all(5),
          //         child: DataBox(
          //           name: 'Y Coord.',
          //           stream: statusStream,
          //           value: 'y',
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Battery Current (A)',
                    stream: batteryStream,
                    value: 'current',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Battery Voltage (V)',
                    stream: batteryStream,
                    value: 'voltage',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Battery Power (W)',
                    stream: batteryStream,
                    value: 'power',
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AtmospBox extends StatelessWidget {
  const AtmospBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              'ATMOSPHERE',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Temperature (°C)',
                    stream: atmosphereStream,
                    value: 'temperature',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Moisture (%)',
                    stream: atmosphereStream,
                    value: 'moisture',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Pressure (kPa)',
                    stream: atmosphereStream,
                    value: 'pressure',
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'CO Amount (ppm)',
                    stream: gasStream,
                    value: 'ppm_co',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'CO2 Amount (ppm)',
                    stream: gasStream,
                    value: 'ppm_co2',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'CH4 Amount (ppm)',
                    stream: gasStream,
                    value: 'ppm_ch4',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'NO2 Amount (ppm)',
                    stream: gasStream,
                    value: 'ppm_no2',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SoilBox extends StatelessWidget {
  const SoilBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              'SOIL',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Temperature (°C)',
                    stream: soilStream,
                    value: 'temperature',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'N Amount (mg/L)',
                    stream: soilStream,
                    value: 'n',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'P Amount (mg/L)',
                    stream: soilStream,
                    value: 'p',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'K Amount (mg/L)',
                    stream: soilStream,
                    value: 'k',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: SaveDataButton(
                    name: "SAVE",
                    stream: soilStream,
                    data: 'soil',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SoilWeightBox extends StatelessWidget {
  const SoilWeightBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              'SOIL WEIGHTS',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Weight #1',
                    stream: weightsStream,
                    value: 'soil_weights',
                    index: 0,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Weight #2',
                    stream: weightsStream,
                    value: 'soil_weights',
                    index: 1,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Weight #3',
                    stream: weightsStream,
                    value: 'soil_weights',
                    index: 2,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: SaveDataButton(
                    name: "SAVE",
                    stream: weightsStream,
                    data: 'weights',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VoltageBox extends StatelessWidget {
  const VoltageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              'PANEL VOLTAGE',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Voltage (mV)',
                    stream: voltageStream,
                    value: 'panel_voltage',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: SaveDataButton(
                    name: "SAVE",
                    stream: voltageStream,
                    data: 'voltage',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CHART BOX
class GasChart extends StatelessWidget {
  final String title;
  final Stream stream;
  final List<Gas> graphData;
  const GasChart({
    Key? key,
    required this.title,
    required this.stream,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        border: Border.all(
          width: 5,
          color: Color(roverLightGrey),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                List<Gas> showngraph = graphData;
                DateTime currentTime = DateTime.now();
                return SfCartesianChart(
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  trackballBehavior: TrackballBehavior(
                    // Enables the trackball
                    enable: true,
                    lineColor: Colors.black26,
                    lineWidth: 2,
                    activationMode: ActivationMode.singleTap,
                    tooltipAlignment: ChartAlignment.near,
                    tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                    tooltipSettings: InteractiveTooltip(
                      textStyle: TextStyle(fontSize: roverFontS),
                    ),
                  ),
                  series: <ChartSeries<Gas, DateTime>>[
                    LineSeries(
                      name: 'C3H8',
                      color: roverGraphRed,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.c3h8,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'C4H10',
                      color: roverGraphOrange,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.c4h10,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'CH4',
                      color: roverGraphYellow,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.ch4,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'CO',
                      color: roverGraphGreen,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.co,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'CO2',
                      color: roverGraphDarkGreen,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.co2,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'Ethanol',
                      color: roverGraphDarkCyan,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.ethanol,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'H2',
                      color: roverGraphCyan,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.h2,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'H2S',
                      color: roverGraphBlue,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.h2s,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'NH3',
                      color: roverGraphDarkBlue,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.nh3,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'NO',
                      color: roverGraphPurple,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.no,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    LineSeries(
                      name: 'NO2',
                      color: roverGraphPink,
                      dataSource: showngraph,
                      xValueMapper: (Gas gas, _) => gas.time,
                      yValueMapper: (Gas gas, _) => gas.no2,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                  ],
                  primaryXAxis: DateTimeAxis(
                    labelFormat: '{value}s',
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    visibleMinimum: currentTime.subtract(
                      const Duration(seconds: 10),
                    ),
                    visibleMaximum: currentTime,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value} ppm',
                    title: AxisTitle(
                      text: 'Parts Per Million',
                      textStyle: TextStyle(
                        color: Color(roverDarkRed),
                        fontSize: roverFontS,
                      ),
                    ),
                    isVisible: true,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    minimum: 0,
                    maximum: 11000,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
// UNUSED!!!

// GRAPHIC BOX
class SpectroChart extends StatelessWidget {
  final String title;
  final Stream stream;
  final List<Spectro> graphData;
  const SpectroChart({
    Key? key,
    required this.title,
    required this.stream,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        border: Border.all(
          width: 5,
          color: Color(roverLightGrey),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                List<Spectro> showngraph = graphData;
                return SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<Spectro, double>>[
                    LineSeries(
                      name: 'Value',
                      color: Color(roverDarkCoral),
                      dataSource: showngraph,
                      xValueMapper: (Spectro dot, _) => dot.wavelength,
                      yValueMapper: (Spectro dot, _) => dot.reflectance,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    labelFormat: '{value} nm',
                    title: AxisTitle(
                      text: 'Wavelength',
                      textStyle: TextStyle(
                        color: Color(roverDarkRed),
                        fontSize: roverFontS,
                      ),
                    ),
                    isVisible: true,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    minimum: 400,
                    maximum: 1000,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '%{value}',
                    title: AxisTitle(
                      text: 'Reflectance',
                      textStyle: TextStyle(
                        color: Color(roverDarkRed),
                        fontSize: roverFontS,
                      ),
                    ),
                    minimum: 0,
                    maximum: 100,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// GRAPH SELECTION BUTTON
class GraphLayoutButton extends StatelessWidget {
  final String title;
  final int layout;
  final Function() notifyParent;
  const GraphLayoutButton({
    Key? key,
    required this.title,
    required this.layout,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (graphLayoutIndex != layout) {
          graphLayoutIndex = layout;
          notifyParent();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: graphLayoutIndex != layout
              ? Color(roverCoral)
              : Color(roverDarkCoral),
          borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: roverFontM,
          ),
        ),
      ),
    );
  }
}
*/
