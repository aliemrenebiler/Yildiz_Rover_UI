import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'generalwidgets.dart';
import '../backend/models.dart';
import '../backend/variables.dart';
import '../backend/theme.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  refresh() {
    setState(() {});
  }

  Widget selectedDataGraph() {
    switch (graphLayoutIndex) {
      case 0:
        return AspectRatio(
          aspectRatio: 1.5,
          child: GasChart(
            title: 'Multiple Gas',
            stream: gasStream,
            graphData: gasGraphArchive,
          ),
        );
      case 1:
        return AspectRatio(
          aspectRatio: 1.5,
          child: SpectroChart(
            title: 'VIS/NIR Reflectance Spectrometer',
            stream: spectro1Stream,
            graphData: spectroGraph1Archive,
          ),
        );
      default:
        return AspectRatio(
          aspectRatio: 1.5,
          child: GasChart(
            title: 'Multiple Gas',
            stream: gasStream,
            graphData: gasGraphArchive,
          ),
        );
    }
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
      body: Column(
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
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0; i < dataGraphAmount; i++)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: GraphLayoutButton(
                                      layout: i,
                                      notifyParent: refresh,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(5),
                            child: selectedDataGraph(),
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
                            child: const AtmospBox(),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: const SoilBox(),
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
    );
  }
}

// DATA BOX INNER WIDGET
class DataBox extends StatelessWidget {
  final String? name;
  final Stream<Object> stream;
  final String value;
  const DataBox({
    Key? key,
    this.name,
    required this.stream,
    required this.value,
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
                    if (double.tryParse(newData[value]) != null) {
                      dataBoxText = newData[value].toStringAsFixed(3);
                    } else {
                      dataBoxText = newData[value].toString();
                    }
                  } else if (snapshot.hasError) {
                    dataBoxText = 'ERROR';
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

// DATA BOX INNER WIDGET
class TiltBox extends StatelessWidget {
  final String? name;
  final Stream<Object> stream;
  final String value;
  const TiltBox({
    Key? key,
    this.name,
    required this.stream,
    required this.value,
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
                    if (double.tryParse(newData[value]) != null) {
                      dataBoxText = newData[value].toStringAsFixed(3);
                    } else {
                      dataBoxText = newData[value].toString();
                    }
                  } else if (snapshot.hasError) {
                    dataBoxText = 'ERROR';
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

// GRAPH SELECTION BUTTON
class GraphLayoutButton extends StatelessWidget {
  final int layout;
  final Function() notifyParent;
  const GraphLayoutButton({
    Key? key,
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
          dataGraphTitles[layout],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    stream: statusStream,
                    value: 'z',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'X Coord.',
                    stream: locationStream,
                    value: 'x',
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
                    name: 'Y Coord.',
                    stream: locationStream,
                    value: 'y',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Z Coord.',
                    stream: locationStream,
                    value: 'z',
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
                    stream: someGasStream,
                    value: 'ppm_co',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'CO2 Amount (ppm)',
                    stream: someGasStream,
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
                    stream: someGasStream,
                    value: 'ppm_ch4',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'NO2 Amount (ppm)',
                    stream: someGasStream,
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
                    value: 'n_amount',
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
                    value: 'p_amount',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'K Amount (mg/L)',
                    stream: soilStream,
                    value: 'k_amount',
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

// GRAPHIC BOXES
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
                List<Gas> showngraph;
                DateTime currentTime;
                if (snapshot.hasData) {
                  Gas newGas = snapshot.data as Gas;
                  showngraph = graphData;
                  currentTime = newGas.time!;
                } else {
                  showngraph = emptyGasGraph;
                  currentTime = DateTime(2000, 1, 1, 0, 0, 10, 0, 0);
                }
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

class SpectroChart extends StatelessWidget {
  final String title;
  final Stream stream;
  final List<List<Spectro1>> graphData;
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
                List<Spectro1> showngraph;
                if (snapshot.hasData) {
                  Spectro1 newSpectro = snapshot.data as Spectro1;
                  showngraph = graphData[newSpectro.id - 1];
                } else {
                  showngraph = emptySpectro1Graph;
                }
                return SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<Spectro1, double>>[
                    LineSeries(
                      name: 'Value',
                      color: Color(roverDarkCoral),
                      dataSource: showngraph,
                      xValueMapper: (Spectro1 dot, _) => dot.wavelength,
                      yValueMapper: (Spectro1 dot, _) => dot.reflectance,
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
