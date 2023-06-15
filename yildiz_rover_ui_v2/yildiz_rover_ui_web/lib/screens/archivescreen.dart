import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../backend/methods.dart';
import 'generalwidgets.dart';
import '../backend/models.dart';
import '../backend/theme.dart';
import '../backend/variables.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  refresh() {
    setState(() {});
  }

  Widget selectedArchiveGraph() {
    switch (graphLayoutIndex) {
      case 0:
        return ArchiveGasChart(
          title: "Multiple Gas",
          graphData: gasGraphArchive,
        );
      case 1:
        return ArchiveNPKChart(
          title: "NPK #1",
          graphData: npkGraphArchive[0],
        );
      case 2:
        return ArchiveSpectro1Chart(
          title: "VIS/NIR Ref. Spec. #1",
          graphData: spectroGraph1Archive[0],
        );
      case 3:
        return ArchiveSpectro2Chart(
          title: "VIS Spectrometer #1",
          graphData: spectroGraph2Archive[0],
        );
      case 4:
        return ArchiveNPKChart(
          title: "NPK #2",
          graphData: npkGraphArchive[1],
        );
      case 5:
        return ArchiveSpectro1Chart(
          title: "VIS/NIR Ref. Spec. #2",
          graphData: spectroGraph1Archive[1],
        );
      case 6:
        return ArchiveSpectro2Chart(
          title: "VIS Spectrometer #2",
          graphData: spectroGraph2Archive[1],
        );
      case 7:
        return ArchiveNPKChart(
          title: "NPK #3",
          graphData: npkGraphArchive[2],
        );
      case 8:
        return ArchiveSpectro1Chart(
          title: "VIS/NIR Ref. Spec. #3",
          graphData: spectroGraph1Archive[2],
        );
      case 9:
        return ArchiveSpectro2Chart(
          title: "VIS Spectrometer #3",
          graphData: spectroGraph2Archive[2],
        );
      case 10:
        return ArchiveNPKChart(
          title: "NPK #4",
          graphData: npkGraphArchive[3],
        );
      case 11:
        return ArchiveSpectro1Chart(
          title: "VIS/NIR Ref. Spec. #4",
          graphData: spectroGraph1Archive[3],
        );
      case 12:
        return ArchiveSpectro2Chart(
          title: "VIS Spectrometer #4",
          graphData: spectroGraph2Archive[3],
        );
      default:
        return ArchiveGasChart(
          title: "Multiple Gas",
          graphData: gasGraphArchive,
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
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: selectedArchiveGraph(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: RefreshButton(
                                notifyParent: refresh,
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: GasButtonBox(notifyParent: refresh)),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: SampleBox(
                                sampleID: 1,
                                notifyParent: refresh,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: SampleBox(
                                sampleID: 2,
                                notifyParent: refresh,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: SampleBox(
                                sampleID: 3,
                                notifyParent: refresh,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: SampleBox(
                                sampleID: 4,
                                notifyParent: refresh,
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
          ),
        ],
      ),
    );
  }
}

// DATA BOX INNER WIDGET
class DataBox extends StatelessWidget {
  final String name;
  final List<double> graphData;
  const DataBox({
    Key? key,
    required this.name,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dataBoxText;
    double countedData;
    if (graphData.isNotEmpty) {
      countedData = countAverage(graphData);
      dataBoxText = countedData.toStringAsFixed(3);
    } else {
      dataBoxText = '--';
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3),
      height: 40,
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(3),
              child: Text(
                name,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
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
              child: Text(
                dataBoxText,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: roverFontM,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// BUTTONS
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
          archiveGraphTitles[layout],
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

class RefreshButton extends StatelessWidget {
  final Function() notifyParent;
  const RefreshButton({
    Key? key,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        notifyParent();
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: Color(roverCoral),
          borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        ),
        child: Text(
          "REFRESH",
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

// SAMPLE BOXES
class GasButtonBox extends StatelessWidget {
  final Function() notifyParent;
  const GasButtonBox({
    Key? key,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
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
              "MULTIPLE GAS",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: GraphLayoutButton(
              layout: 0,
              notifyParent: notifyParent,
            ),
          ),
        ],
      ),
    );
  }
}

class SampleBox extends StatelessWidget {
  final int sampleID;
  final Function() notifyParent;
  const SampleBox({
    Key? key,
    required this.sampleID,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int layoutID = sampleID - 1;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
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
              "SAMPLE #$sampleID",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: roverFontL,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DataBox(
              name: "Temperature (°C)",
              graphData: soilTempGraphArchive[layoutID],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DataBox(
              name: "pH Value",
              graphData: soilPHGraphArchive[layoutID],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: GraphLayoutButton(
              layout: layoutID * 3 + 1,
              notifyParent: notifyParent,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: GraphLayoutButton(
              layout: layoutID * 3 + 2,
              notifyParent: notifyParent,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: GraphLayoutButton(
              layout: layoutID * 3 + 3,
              notifyParent: notifyParent,
            ),
          ),
        ],
      ),
    );
  }
}

// GRAPH BOXES
class ArchiveGasChart extends StatelessWidget {
  final String title;
  final List<Gas> graphData;
  const ArchiveGasChart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Gas> showngraph;
    DateTime currentTime;

    if (graphData.isNotEmpty) {
      showngraph = graphData;
      currentTime = graphData.last.time!;
    } else {
      showngraph = emptyGasGraph;
      currentTime = DateTime(2000, 1, 1, 0, 0, 10, 0, 0);
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
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
            child: MouseRegion(
              onEnter: (PointerEvent details) => {hoverController.add(true)},
              onExit: (PointerEvent details) => {hoverController.add(false)},
              child: SfCartesianChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                zoomPanBehavior: ZoomPanBehavior(
                  zoomMode: ZoomMode.x,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArchiveNPKChart extends StatelessWidget {
  final String title;
  final List<NPK> graphData;
  const ArchiveNPKChart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NPK> showngraph = graphData;
    DateTime currentTime;

    if (showngraph.isNotEmpty) {
      currentTime = graphData.last.time!;
    } else {
      currentTime = DateTime(2000, 1, 1, 0, 0, 10, 0, 0);
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
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
            child: SfCartesianChart(
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              zoomPanBehavior: ZoomPanBehavior(
                zoomMode: ZoomMode.x,
                enablePanning: true,
                enableMouseWheelZooming: true,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<NPK, DateTime>>[
                LineSeries(
                  name: 'N Value',
                  color: Colors.red,
                  dataSource: showngraph,
                  xValueMapper: (NPK dot, _) => dot.time,
                  yValueMapper: (NPK dot, _) => dot.n,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
                LineSeries(
                  name: 'P Value',
                  color: Colors.green,
                  dataSource: showngraph,
                  xValueMapper: (NPK dot, _) => dot.time,
                  yValueMapper: (NPK dot, _) => dot.p,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
                LineSeries(
                  name: 'K Value',
                  color: Colors.blue,
                  dataSource: showngraph,
                  xValueMapper: (NPK dot, _) => dot.time,
                  yValueMapper: (NPK dot, _) => dot.k,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: DateTimeAxis(
                labelFormat: '{value}s',
                isVisible: true,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                visibleMinimum:
                    currentTime.subtract(const Duration(seconds: 10)),
                visibleMaximum: currentTime,
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

class ArchiveSpectro1Chart extends StatelessWidget {
  final String title;
  final List<Spectro1> graphData;
  const ArchiveSpectro1Chart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Spectro1> showngraph = graphData;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
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
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Spectro1, double>>[
                LineSeries(
                  name: 'Value',
                  color: Color(roverDarkCoral),
                  dataSource: showngraph,
                  xValueMapper: (Spectro1 dot, _) => dot.wavelength,
                  yValueMapper: (Spectro1 dot, _) => dot.reflectance,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
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
            ),
          ),
        ],
      ),
    );
  }
}

class ArchiveSpectro2Chart extends StatelessWidget {
  final String title;
  final List<Spectro2> graphData;
  const ArchiveSpectro2Chart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Spectro2> showngraph = graphData;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
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
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Spectro2, double>>[
                LineSeries(
                  name: 'Value',
                  color: Color(roverDarkCoral),
                  dataSource: showngraph,
                  xValueMapper: (Spectro2 dot, _) => dot.wavelength,
                  yValueMapper: (Spectro2 dot, _) => dot.transmittance,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
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
                  text: 'Transmittance',
                  textStyle: TextStyle(
                    color: Color(roverDarkRed),
                    fontSize: roverFontS,
                  ),
                ),
                minimum: 0,
                maximum: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// UNUSED GRAPHES
class ArchiveSoilTempChart extends StatelessWidget {
  final String title;
  final List<List<double>> graphData;
  const ArchiveSoilTempChart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SoilTempPHData> countedGraphData = [
      SoilTempPHData(
        title: 'Sample 1',
        temperature: graphData[0].isNotEmpty ? countAverage(graphData[0]) : 0,
      ),
      SoilTempPHData(
        title: 'Sample 2',
        temperature: graphData[1].isNotEmpty ? countAverage(graphData[1]) : 0,
      ),
      SoilTempPHData(
        title: 'Sample 3',
        temperature: graphData[2].isNotEmpty ? countAverage(graphData[2]) : 0,
      ),
      SoilTempPHData(
        title: 'Sample 4',
        temperature: graphData[3].isNotEmpty ? countAverage(graphData[3]) : 0,
      ),
    ];

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
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
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<SoilTempPHData, String>>[
                ColumnSeries(
                  name: 'Value',
                  color: Color(roverDarkCoral),
                  borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
                  dataSource: countedGraphData,
                  xValueMapper: (SoilTempPHData dot, _) => dot.title,
                  yValueMapper: (SoilTempPHData dot, _) => dot.temperature,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                  text: 'Time',
                  textStyle: TextStyle(
                    color: Color(roverDarkRed),
                    fontSize: roverFontS,
                  ),
                ),
                isVisible: true,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                plotOffset: (MediaQuery.of(context).size.height - 200) / 3,
                crossesAt: 0,
                placeLabelsNearAxisLine: false,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}°C',
                title: AxisTitle(
                  text: 'Temperature',
                  textStyle: TextStyle(
                    color: Color(roverDarkRed),
                    fontSize: roverFontS,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArchiveSoilPHChart extends StatelessWidget {
  final String title;
  final List<List<double>> graphData;
  const ArchiveSoilPHChart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SoilTempPHData> countedGraphData = [
      SoilTempPHData(
        title: 'Sample 1',
        pH: graphData[0].isNotEmpty ? countAverage(graphData[0]) : 7,
      ),
      SoilTempPHData(
        title: 'Sample 2',
        pH: graphData[1].isNotEmpty ? countAverage(graphData[1]) : 7,
      ),
      SoilTempPHData(
        title: 'Sample 3',
        pH: graphData[2].isNotEmpty ? countAverage(graphData[2]) : 7,
      ),
      SoilTempPHData(
        title: 'Sample 4',
        pH: graphData[3].isNotEmpty ? countAverage(graphData[3]) : 7,
      ),
    ];

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
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
            child: SfCartesianChart(
              onMarkerRender: (args) {
                if (countedGraphData[args.pointIndex!].pH! > 7) {
                  args.color = roverGraphBlue;
                  args.borderColor = roverGraphBlue;
                } else if (countedGraphData[args.pointIndex!].pH! < 7) {
                  args.color = roverGraphRed;
                  args.borderColor = roverGraphRed;
                } else {
                  args.color = Color(roverGrey);
                  args.borderColor = Color(roverGrey);
                }
              },
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<SoilTempPHData, String>>[
                ScatterSeries(
                  name: 'Value',
                  dataSource: countedGraphData,
                  color: Colors.white,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    height: MediaQuery.of(context).size.height / 60,
                    width: (MediaQuery.of(context).size.height - 200) / 6,
                    shape: DataMarkerType.rectangle,
                  ),
                  xValueMapper: (SoilTempPHData data, _) => data.title,
                  yValueMapper: (SoilTempPHData data, _) => data.pH,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: CategoryAxis(
                isVisible: true,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                plotOffset: (MediaQuery.of(context).size.height - 200) / 3,
                crossesAt: 7,
                placeLabelsNearAxisLine: false,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                  text: 'pH',
                  textStyle: TextStyle(
                    color: Color(roverDarkRed),
                    fontSize: roverFontS,
                  ),
                ),
                edgeLabelPlacement: EdgeLabelPlacement.hide,
                minimum: -1,
                maximum: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
