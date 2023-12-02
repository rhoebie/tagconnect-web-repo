import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class BarGraphWidget extends StatefulWidget {
  const BarGraphWidget({super.key});

  @override
  State<BarGraphWidget> createState() => _BarGraphWidgetState();
}

class _BarGraphWidgetState extends State<BarGraphWidget> {
  double barWidth = 12.0;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: 7, color: tcViolet, width: barWidth),
            BarChartRodData(toY: 4, color: tcGray, width: barWidth),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 8, color: tcViolet, width: barWidth),
            BarChartRodData(toY: 15, color: tcGray, width: barWidth),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 10, color: tcViolet, width: barWidth),
            BarChartRodData(toY: 8, color: tcGray, width: barWidth),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 2, color: tcViolet, width: barWidth),
            BarChartRodData(toY: 1, color: tcGray, width: barWidth),
          ]),
        ],
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: tcAsh,
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
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
                  case 0:
                    return const Text('General');
                  case 1:
                    return const Text('Medical');
                  case 2:
                    return const Text('Fire');
                  case 3:
                    return const Text('Crime');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
