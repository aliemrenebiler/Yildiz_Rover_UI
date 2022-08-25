import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../backend/classes.dart';
import '../backend/methods/general_methods.dart';
import '../backend/methods/saving_methods.dart';
import 'generalwidgets.dart';
import '../backend/theme.dart';

int graphLayoutIndex = 0;

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
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
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const MultiGasBox(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const VoltageBox(),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const AllWeightsBox(),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const AllSamplesBox(),
                            )
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
class DynamicDataBox extends StatelessWidget {
  final String? name;
  final Stream<Object> stream;
  final String value;
  const DynamicDataBox({
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
                    if (double.tryParse(value) != null) {
                      dataBoxText = double.parse(value).toStringAsFixed(3);
                    } else {
                      dataBoxText = value;
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

class StaticDataBox extends StatelessWidget {
  final String? name;
  final String value;
  const StaticDataBox({
    Key? key,
    this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dataBoxText;
    if (double.tryParse(value) != null) {
      dataBoxText = double.parse(value).toStringAsFixed(3);
    } else {
      dataBoxText = value;
    }
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

// ARCHIVE BOXES
class MultiGasBox extends StatelessWidget {
  const MultiGasBox({Key? key}) : super(key: key);

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
              'MULTIPLE GAS AVERAGES',
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
            child: DynamicDataBox(
              name: 'C3H8 (ppm)',
              stream: gasStream,
              value: avrgGas.c3h8.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'C4H10 (ppm)',
              stream: gasStream,
              value: avrgGas.c4h10.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'CH4 (ppm)',
              stream: gasStream,
              value: avrgGas.ch4.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'CO (ppm)',
              stream: gasStream,
              value: avrgGas.co.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'CO2 (ppm)',
              stream: gasStream,
              value: avrgGas.co2.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'Ethanol (ppm)',
              stream: gasStream,
              value: avrgGas.ethanol.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'H2 (ppm)',
              stream: gasStream,
              value: avrgGas.h2.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'H2S (ppm)',
              stream: gasStream,
              value: avrgGas.h2s.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'NH3 (ppm)',
              stream: gasStream,
              value: avrgGas.nh3.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'NO (ppm)',
              stream: gasStream,
              value: avrgGas.no.toString(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: DynamicDataBox(
              name: 'NO2 (ppm)',
              stream: gasStream,
              value: avrgGas.no2.toString(),
            ),
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
          Container(
            margin: const EdgeInsets.all(5),
            child: DataBox(
              name: 'Voltage (mV)',
              stream: voltageStream,
              value: 'panel_voltage',
            ),
          ),
        ],
      ),
    );
  }
}

class WeightBox extends StatelessWidget {
  final int sample;
  const WeightBox({
    Key? key,
    required this.sample,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              "Sample #${weightSamples[sample].id}",
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
            child: StaticDataBox(
              name: 'Time',
              value:
                  "${weightSamples[sample].date!.hour}:${weightSamples[sample].date!.minute}:${weightSamples[sample].date!.second}",
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: StaticDataBox(
              name: 'Weight (g)',
              value: weightSamples[sample].weight.toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class AllWeightsBox extends StatelessWidget {
  const AllWeightsBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: StreamBuilder<Object>(
        stream: soilStream,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                height: 40,
                child: Text(
                  "SOIL WEIGHTS",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: roverFontL,
                  ),
                ),
              ),
              if (soilSamples.isEmpty)
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    "No Avaliabe Sample",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(roverDarkCoral),
                      fontWeight: FontWeight.bold,
                      fontSize: roverFontM,
                    ),
                  ),
                )
              else
                for (int i = 0; i < weightSamples.length; i++)
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: WeightBox(sample: i),
                  ),
            ],
          );
        },
      ),
    );
  }
}

class SampleBox extends StatelessWidget {
  final int sample;
  const SampleBox({
    Key? key,
    required this.sample,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkCoral),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 40,
            child: Text(
              "Sample #${soilSamples[sample].id}",
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: StaticDataBox(
                    name: 'Temperature (°C)',
                    value: soilSamples[sample].temperature.toString(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: StaticDataBox(
                    name: 'N Amount (mg/L)',
                    value: soilSamples[sample].n.toString(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: StaticDataBox(
                    name: 'P Amount (mg/L)',
                    value: soilSamples[sample].p.toString(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: StaticDataBox(
                    name: 'K Amount (mg/L)',
                    value: soilSamples[sample].k.toString(),
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

class AllSamplesBox extends StatelessWidget {
  const AllSamplesBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(roverDarkRed),
        borderRadius: BorderRadius.all(Radius.circular(roverRadiusL)),
      ),
      child: StreamBuilder<Object>(
        stream: soilStream,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                height: 40,
                child: Text(
                  "SOIL SAMPLES",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: roverFontL,
                  ),
                ),
              ),
              if (soilSamples.isEmpty)
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    "No Avaliabe Sample",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(roverDarkCoral),
                      fontWeight: FontWeight.bold,
                      fontSize: roverFontM,
                    ),
                  ),
                )
              else
                for (int i = 0; i < soilSamples.length; i++)
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: SampleBox(sample: i),
                  ),
            ],
          );
        },
      ),
    );
  }
}

// SAMPLE BOXES
class ArchiveSpectroChart extends StatelessWidget {
  final String title;
  final List<Spectro> graphData;
  const ArchiveSpectroChart({
    Key? key,
    required this.title,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Spectro> showngraph = graphData;

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
              series: <ChartSeries<Spectro, double>>[
                LineSeries(
                  name: 'Value',
                  color: Color(roverDarkCoral),
                  dataSource: showngraph,
                  xValueMapper: (Spectro dot, _) => dot.wavelength,
                  yValueMapper: (Spectro dot, _) => dot.reflectance,
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
