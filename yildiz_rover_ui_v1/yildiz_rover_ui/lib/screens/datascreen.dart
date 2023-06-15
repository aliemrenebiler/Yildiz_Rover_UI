import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:roslib/roslib.dart';

import 'generalwidgets.dart';
import '../database/methods.dart';
import '../database/variables.dart';
import '../database/theme.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

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
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder<Object>(
                        stream: hoverGasGraphStream,
                        builder: (contextHoverGasGraph, snapshotHoverGasGraph) {
                          return SingleChildScrollView(
                            primary: false,
                            scrollDirection: Axis.vertical,
                            physics: (snapshotHoverGasGraph.data == true)
                                ? const NeverScrollableScrollPhysics()
                                : const BouncingScrollPhysics(),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  AspectRatio(
                                    aspectRatio: 1.5,
                                    child: MultiGasChart(),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.5,
                                    child: SpectrophotoChart(),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.5,
                                    child: NPKChart(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            AtmospBox(),
                            SoilBox(),
                            LocationBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DATA BOXES
class AtmospBox extends StatelessWidget {
  const AtmospBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
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
                fontFamily: 'Roboto',
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
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'temperature',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Moisture (%)',
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'moisture',
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
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'pressure',
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
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'ppm_co',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'CO₂ Amount (ppm)',
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'ppm_co2',
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
                    name: 'CH₄ Amount (ppm)',
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'ppm_ch4',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'NO₂ Amount (ppm)',
                    topicName: atmosphere,
                    msgName: 'msg',
                    dataName: 'ppm_no2',
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
      margin: const EdgeInsets.all(5),
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
                fontFamily: 'Roboto',
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
                    topicName: soil,
                    msgName: 'msg',
                    dataName: 'temperature',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'pH Value',
                    topicName: soil,
                    msgName: 'msg',
                    dataName: 'ph',
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

class LocationBox extends StatelessWidget {
  const LocationBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
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
              'LOCATION',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
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
                    name: 'X Coord.',
                    topicName: location,
                    msgName: 'msg',
                    dataName: 'x',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Y Coord.',
                    topicName: location,
                    msgName: 'msg',
                    dataName: 'y',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: DataBox(
                    name: 'Z Coord.',
                    topicName: location,
                    msgName: 'msg',
                    dataName: 'z',
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
                  child: StableDataBox(
                    name: 'Last Altitude',
                    stream: altitudeStream,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: StableDataBox(
                    name: 'Last Lattitude',
                    stream: lattitudeStream,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: InputBox(
                      text: 'New Altitude', controller: textController1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: InputBox(
                      text: 'New Lattitude', controller: textController2),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: const SendButton(func: publishLocation),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// BOX INNER WIDGETS
class DataBox extends StatelessWidget {
  final String name;
  final Topic topicName;
  final String msgName;
  final String dataName;
  const DataBox({
    Key? key,
    required this.name,
    required this.topicName,
    required this.msgName,
    required this.dataName,
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
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(3),
              child: Text(
                name,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: roverFontM,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(3),
              height: 28,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(roverRadiusM)),
              ),
              child: StreamBuilder(
                stream: topicName.subscription,
                builder: (contextDataBox, snapshotDataBox) {
                  String dataBoxText;
                  if (snapshotDataBox.hasData) {
                    var subData = snapshotDataBox.data as Map;
                    dataBoxText = subData[msgName][dataName].toStringAsFixed(2);
                  } else if (snapshotDataBox.hasError) {
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
                      fontFamily: 'Roboto',
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

class StableDataBox extends StatelessWidget {
  final String name;
  final Stream<String> stream;
  const StableDataBox({
    Key? key,
    required this.name,
    required this.stream,
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
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(3),
              child: Text(
                name,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: roverFontM,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(3),
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(roverRadiusM)),
              ),
              child: StreamBuilder<String>(
                stream: stream,
                builder: (contextStableDataBox, snapshotStableDataBox) {
                  String dataBoxText;
                  if (snapshotStableDataBox.hasData) {
                    dataBoxText = snapshotStableDataBox.data!.toString();
                  } else {
                    dataBoxText = '--';
                  }
                  return Text(
                    dataBoxText,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
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

class InputBox extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const InputBox({Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: TextField(
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.black,
          fontSize: roverFontM,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
        cursorColor: Color(roverDarkRed),
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          hintStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Color(roverGrey),
            fontSize: roverFontM,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final Function() func;
  const SendButton({Key? key, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: Color(roverCoral),
          borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        ),
        child: Text(
          'SEND',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: roverFontM,
          ),
        ),
      ),
    );
  }
}

// GRAPHIC BOXES
class MultiGasChart extends StatelessWidget {
  const MultiGasChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
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
              'Multiple Gas Graph',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Expanded(
            child: MouseRegion(
              onEnter: (PointerEvent details) =>
                  {hoverGasGraphController.add(true)},
              onExit: (PointerEvent details) =>
                  {hoverGasGraphController.add(false)},
              child: StreamBuilder(
                stream: gasgraph.subscription,
                builder: (contextGasChart, snapshotGasChart) {
                  List<MultiGasData> showngraph;
                  MultiGasData? newData;
                  double graphCurrentValue;
                  if (snapshotGasChart.hasData) {
                    showngraph = multiGasGraphData;
                    var subData = snapshotGasChart.data as Map;
                    newData = MultiGasData(
                      subData['msg']['time'],
                      subData['msg']['ppm_c3h8'],
                      subData['msg']['ppm_c4h10'],
                      subData['msg']['ppm_ch4'],
                      subData['msg']['ppm_co'],
                      subData['msg']['ppm_co2'],
                      subData['msg']['ppm_ethanol'],
                      subData['msg']['ppm_h2'],
                      subData['msg']['ppm_h2s'],
                      subData['msg']['ppm_nh3'],
                      subData['msg']['ppm_no'],
                      subData['msg']['ppm_no2'],
                    );
                    graphCurrentValue = newData.time;
                    multiGasGraphData.add(newData);
                  } else {
                    showngraph = emptyGasData;
                    graphCurrentValue = 10;
                  }
                  return SfCartesianChart(
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    zoomPanBehavior: ZoomPanBehavior(
                      zoomMode: ZoomMode.xy,
                      enablePanning: true,
                      enableMouseWheelZooming: true,
                    ),
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
                    series: <ChartSeries>[
                      LineSeries<MultiGasData, double>(
                        name: 'C₃H₈',
                        color: roverGraphRed,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.c3h8,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'C₄H₁₀',
                        color: roverGraphOrange,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.c4h10,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'CH₄',
                        color: roverGraphYellow,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.ch4,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'CO',
                        color: roverGraphGreen,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.co,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'CO₂',
                        color: roverGraphDarkGreen,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.co2,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'Ethanol',
                        color: roverGraphDarkCyan,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.ethanol,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'H₂',
                        color: roverGraphCyan,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.h2,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'H₂S',
                        color: roverGraphBlue,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.h2s,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'NH₃',
                        color: roverGraphDarkBlue,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.nh3,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'NO',
                        color: roverGraphPurple,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.no,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                      LineSeries<MultiGasData, double>(
                        name: 'NO₂',
                        color: roverGraphPink,
                        dataSource: showngraph,
                        xValueMapper: (MultiGasData gas, _) => gas.time,
                        yValueMapper: (MultiGasData gas, _) => gas.no2,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        animationDuration: 0,
                      ),
                    ],
                    primaryXAxis: NumericAxis(
                      labelFormat: '{value}s',
                      visibleMinimum: graphCurrentValue - 10,
                      visibleMaximum: graphCurrentValue,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value} ppm',
                      title: AxisTitle(
                        text: 'Parts Per Million',
                        textStyle: TextStyle(
                          color: Color(roverDarkRed),
                          fontFamily: 'Roboto',
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
          ),
        ],
      ),
    );
  }
}

class NPKChart extends StatelessWidget {
  const NPKChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
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
              'NPK Graph',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                LineSeries<NPKData, double>(
                  name: 'N Value',
                  color: Colors.red,
                  dataSource: npkGraphData,
                  xValueMapper: (NPKData dot, _) => dot.time,
                  yValueMapper: (NPKData dot, _) => dot.n,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
                LineSeries<NPKData, double>(
                  name: 'P Value',
                  color: Colors.green,
                  dataSource: npkGraphData,
                  xValueMapper: (NPKData dot, _) => dot.time,
                  yValueMapper: (NPKData dot, _) => dot.p,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
                LineSeries<NPKData, double>(
                  name: 'K Value',
                  color: Colors.blue,
                  dataSource: npkGraphData,
                  xValueMapper: (NPKData dot, _) => dot.time,
                  yValueMapper: (NPKData dot, _) => dot.k,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: NumericAxis(
                labelFormat: '{value}s',
                isVisible: true,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                minimum: 0,
                maximum: 15,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value} mg/L',
                minimum: 0,
                maximum: 2000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpectrophotoChart extends StatelessWidget {
  const SpectrophotoChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
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
              'Spectrophotometer Graph',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: spectrograph.subscription,
              builder: (context, snapshot) {
                List<SpectroData> showngraph;
                if (snapshot.hasData) {
                  showngraph = spectroGraphData;
                } else {
                  showngraph = dumpSpectroData;
                }
                return SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries>[
                    LineSeries<SpectroData, double>(
                      name: 'Value',
                      color: Color(roverDarkCoral),
                      dataSource: showngraph,
                      xValueMapper: (SpectroData dot, _) => dot.wavelength,
                      yValueMapper: (SpectroData dot, _) => dot.transmittance,
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
                        fontFamily: 'Roboto',
                        fontSize: roverFontS,
                      ),
                    ),
                    isVisible: true,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    minimum: 400,
                    maximum: 700,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '%{value}',
                    title: AxisTitle(
                      text: 'Transmittance',
                      textStyle: TextStyle(
                        color: Color(roverDarkRed),
                        fontFamily: 'Roboto',
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

/*
Use these numbers for labeling molecules:
₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉
*/

// Command Box not worked properly, it is canceled.
/*
class CommandBox extends StatelessWidget {
  const CommandBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
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
              'COMMAND',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: InputBox(
                      text: 'Command Here', controller: textController3),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: const SendButton(func: runCommand),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
