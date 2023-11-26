import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineGraph extends StatefulWidget {
  const LineGraph({super.key});

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 650,
        height: 300,
        child: SfCartesianChart(
          series: <LineSeries>[
            LineSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData('Monday', 10),
                  ChartData('Tuesday', 1),
                  ChartData('Wednesday', 13),
                  ChartData('Thursday', 14),
                  ChartData('Friday', 15),
                  ChartData('Saturday', 6),
                  ChartData('Sunday', 7),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'General',
                color: Colors.yellow),
            LineSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData('Monday', 2),
                  ChartData('Tuesday', 3),
                  ChartData('Wednesday', 44),
                  ChartData('Thursday', 35),
                  ChartData('Friday', 6),
                  ChartData('Saturday', 74),
                  ChartData('Sunday', 8),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Fire',
                color: Colors.red),
            LineSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData('Monday', 5),
                  ChartData('Tuesday', 631),
                  ChartData('Wednesday', 711),
                  ChartData('Thursday', 823),
                  ChartData('Friday', 9),
                  ChartData('Saturday', 1),
                  ChartData('Sunday', 11),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Medical',
                color: Colors.green),
            LineSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData('Monday', 13),
                  ChartData('Tuesday', 10),
                  ChartData('Wednesday', 30),
                  ChartData('Thursday', 40),
                  ChartData('Friday', 19),
                  ChartData('Saturday', 6),
                  ChartData('Sunday', 1),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Crime',
                color: Colors.blue),
          ],
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Comparison of Incident Types'),
          legend: Legend(isVisible: true),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
