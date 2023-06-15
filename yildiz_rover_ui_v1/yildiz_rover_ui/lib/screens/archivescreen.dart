import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'generalwidgets.dart';
import '../database/theme.dart';
import '../database/variables.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  refresh() {
    setState(() {});
  }

  Widget selectedGraph() {
    if (graphLayoutIndex < 4) {
      return ArchiveNPKGraph(
        title: graphTitles[graphLayoutIndex],
        graph: allGraphs[graphLayoutIndex],
      );
    } else if (graphLayoutIndex < 12) {
      return ArchiveSpectroGraph(
        title: graphTitles[graphLayoutIndex],
        graph: allGraphs[graphLayoutIndex],
      );
    } else if (graphLayoutIndex == 12) {
      return ArchiveSoilTempGraph(
        title: graphTitles[graphLayoutIndex],
        graph: allGraphs[graphLayoutIndex],
      );
    } else {
      return ArchiveSoilPHGraph(
        title: graphTitles[graphLayoutIndex],
        graph: allGraphs[graphLayoutIndex],
      );
    }
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
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: selectedGraph(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 14; i++)
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: GraphLayoutButton(
                              layout: i,
                              notifyParent: refresh,
                            ),
                          ),
                      ],
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
        width: MediaQuery.of(context).size.width / 8,
        decoration: BoxDecoration(
          color: graphLayoutIndex != layout
              ? Color(roverCoral)
              : Color(roverDarkCoral),
          borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
        ),
        child: Text(
          graphTitles[layout],
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

class ArchiveNPKGraph extends StatelessWidget {
  final String title;
  final List<NPKData> graph;
  const ArchiveNPKGraph({Key? key, required this.title, required this.graph})
      : super(key: key);

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
              title,
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
                  color: Color(roverDarkCoral),
                  dataSource: graph,
                  xValueMapper: (NPKData dot, _) => dot.time,
                  yValueMapper: (NPKData dot, _) => dot.n,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
                LineSeries<NPKData, double>(
                  name: 'P Value',
                  color: Colors.green,
                  dataSource: graph,
                  xValueMapper: (NPKData dot, _) => dot.time,
                  yValueMapper: (NPKData dot, _) => dot.p,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
                LineSeries<NPKData, double>(
                  name: 'K Value',
                  color: Colors.blue,
                  dataSource: graph,
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
                maximum: 10,
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

class ArchiveSpectroGraph extends StatelessWidget {
  final String title;
  final List<SpectroData> graph;
  const ArchiveSpectroGraph(
      {Key? key, required this.title, required this.graph})
      : super(key: key);

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
              title,
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
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                LineSeries<SpectroData, double>(
                  name: 'Value',
                  color: Color(roverDarkCoral),
                  dataSource: graph,
                  xValueMapper: (SpectroData dot, _) => dot.wavelength,
                  yValueMapper: (SpectroData dot, _) => dot.transmittance,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: NumericAxis(
                labelFormat: '{value} nm',
                labelRotation: 90,
                title: AxisTitle(
                  text: 'Wavelength',
                  textStyle: TextStyle(
                    color: Color(roverDarkRed),
                    fontFamily: 'Roboto',
                    fontSize: roverFontS,
                  ),
                ),
                isVisible: true,
                edgeLabelPlacement: EdgeLabelPlacement.none,
                minimum: 300,
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
            ),
          ),
        ],
      ),
    );
  }
}

class ArchiveSoilTempGraph extends StatelessWidget {
  final String title;
  final List<SoilTempData> graph;
  const ArchiveSoilTempGraph(
      {Key? key, required this.title, required this.graph})
      : super(key: key);

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
              title,
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
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<SoilTempData, String>>[
                ColumnSeries<SoilTempData, String>(
                  name: 'Value',
                  color: Color(roverDarkCoral),
                  borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
                  dataSource: graph,
                  xValueMapper: (SoilTempData dot, _) => dot.time,
                  yValueMapper: (SoilTempData dot, _) => dot.temperature,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                  text: 'Time',
                  textStyle: TextStyle(
                    color: Color(roverDarkRed),
                    fontFamily: 'Roboto',
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
                    fontFamily: 'Roboto',
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

class ArchiveSoilPHGraph extends StatelessWidget {
  final String title;
  final List<SoilPHData> graph;
  const ArchiveSoilPHGraph({Key? key, required this.title, required this.graph})
      : super(key: key);

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
              title,
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
              onMarkerRender: (args) {
                if (graph[args.pointIndex!].pH > 7) {
                  args.color = roverGraphBlue;
                  args.borderColor = roverGraphBlue;
                } else if (graph[args.pointIndex!].pH < 7) {
                  args.color = roverGraphRed;
                  args.borderColor = roverGraphRed;
                } else {
                  args.color = Color(roverGrey);
                  args.borderColor = Color(roverGrey);
                }
              },
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<SoilPHData, String>>[
                ScatterSeries<SoilPHData, String>(
                  name: 'Value',
                  dataSource: graph,
                  color: Colors.white,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    height: MediaQuery.of(context).size.height / 60,
                    width: (MediaQuery.of(context).size.height - 200) / 6,
                    shape: DataMarkerType.rectangle,
                  ),
                  xValueMapper: (SoilPHData data, _) => data.time,
                  yValueMapper: (SoilPHData data, _) => data.pH,
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
                    fontFamily: 'Roboto',
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

/*
StreamBuilder<dynamic>(
  stream: camera!.subscription,
  builder: (context, snapshotCam) {
    return Image(image: snapshotCam.data);
  },
),
*/
