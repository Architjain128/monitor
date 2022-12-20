import 'package:flutter/material.dart';
import 'package:montior/form.dart';
import 'package:montior/scale.dart';
import 'package:montior/tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'databaseRequests.dart';
import 'tile.dart';

class MyChart extends StatefulWidget {
  final UserData data;
  MyChart({Key? key, required this.data}) : super(key: key);
  @override
  MyChartState createState() => MyChartState();
}

class MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    late TrackballDisplayMode _mode = TrackballDisplayMode.floatAllPoints;
    return SingleChildScrollView(
        child: Column(children: [
      //Initialize the chart widget
      MyScale(),
      MyDataTile(data: widget.data.latest, title: "Latest"),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: "Date"),
            axisLine: const AxisLine(width: 1),
            isVisible: false,
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            axisLine: const AxisLine(width: 1),
            majorTickLines: const MajorTickLines(color: Colors.transparent),
          ),
          // Chart title
          title: ChartTitle(text: 'Blood Pressure Analysis'),
          // Enable legend
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          trackballBehavior: TrackballBehavior(
            enable: true,
            markerSettings: TrackballMarkerSettings(
              color: Colors.black,
              markerVisibility: TrackballVisibilityMode.visible,
              height: 10,
              width: 10,
              borderWidth: 1,
            ),
            hideDelay: 1000,
            activationMode: ActivationMode.singleTap,
            tooltipAlignment: ChartAlignment.center,
            tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
            tooltipSettings: InteractiveTooltip(
                format: _mode != TrackballDisplayMode.groupAllPoints
                    ? 'series.name : point.y'
                    : null,
                canShowMarker: true),
            shouldAlwaysShow: false,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            zoomMode: ZoomMode.x,
            enablePanning: true,
            enableMouseWheelZooming: true,
          ),
          series: <ChartSeries<Entry, String>>[
            LineSeries<Entry, String>(
              enableTooltip: false,
              dataSource: widget.data.lis,
              xValueMapper: (Entry sales, _) => sales.date,
              yValueMapper: (Entry sales, _) => int.parse(sales.sys!),
              name: 'SYS',
              markerSettings: const MarkerSettings(isVisible: true),
            ),
            LineSeries<Entry, String>(
              enableTooltip: false,
              dataSource: widget.data.lis,
              xValueMapper: (Entry sales, _) => sales.date,
              yValueMapper: (Entry sales, _) => int.parse(sales.dia!),
              name: 'DIA',
              markerSettings: const MarkerSettings(isVisible: true),
            ),
          ],
        ),
      ),
    ]));
  }
}
