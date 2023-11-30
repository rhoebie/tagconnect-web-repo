import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class LineGraphWidget extends StatefulWidget {
  const LineGraphWidget({super.key});

  @override
  State<LineGraphWidget> createState() => _LineGraphWidgetState();
}

class _LineGraphWidgetState extends State<LineGraphWidget> {
  final _data1 = <double, double>{
    1: 75,
    2: 43,
    3: 20,
    4: 28,
    5: 34,
    6: 50,
    7: 23
  };

  @override
  Widget build(BuildContext context) {
    final spots1 = <FlSpot>[
      for (final entry in _data1.entries) FlSpot(entry.key, entry.value)
    ];

    final lineChartData = LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots1,
          color: tcViolet,
          barWidth: 5,
          isCurved: true,
          dotData: const FlDotData(show: true),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: tcAsh,
        ),
        touchCallback: (_, __) {},
        handleBuiltInTouches: true,
      ),
      borderData: FlBorderData(
        show: false,
        border: const Border(
          bottom: BorderSide(color: Colors.greenAccent, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: false,
            getTitlesWidget: (double val, _) {
              switch (val.toInt()) {
                case 1:
                  return const Text('Mon');
                case 2:
                  return const Text('Tue');
                case 3:
                  return const Text('Wed');
                case 4:
                  return const Text('Thu');
                case 5:
                  return const Text('Fri');
                case 6:
                  return const Text('Sat');
                case 7:
                  return const Text('Sun');
                default:
                  return const Text('');
              }
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            getTitlesWidget: (double val, _) {
              switch (val.toInt()) {
                case 1:
                  return const Text('Mon');
                case 2:
                  return const Text('Tue');
                case 3:
                  return const Text('Wed');
                case 4:
                  return const Text('Thu');
                case 5:
                  return const Text('Fri');
                case 6:
                  return const Text('Sat');
                case 7:
                  return const Text('Sun');
                default:
                  return const Text('');
              }
            },
          ),
        ),
      ),
    );
    return LineChart(lineChartData);
  }
}
