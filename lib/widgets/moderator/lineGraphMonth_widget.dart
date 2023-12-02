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
    7: 23,
    8: 20,
    9: 28,
    10: 34,
    11: 50,
    12: 23,
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
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [tcWhite, tcViolet],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
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
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.white, width: 15),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      gridData: const FlGridData(show: true, drawVerticalLine: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            getTitlesWidget: (double val, _) {
              switch (val.toInt()) {
                case 1:
                  return const Text('Jan');
                case 2:
                  return const Text('Feb');
                case 3:
                  return const Text('Mar');
                case 4:
                  return const Text('Apr');
                case 5:
                  return const Text('May');
                case 6:
                  return const Text('Jun');
                case 7:
                  return const Text('Jul');
                case 8:
                  return const Text('Aug');
                case 9:
                  return const Text('Sep');
                case 10:
                  return const Text('Oct');
                case 11:
                  return const Text('Nov');
                case 12:
                  return const Text('Dec');
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
