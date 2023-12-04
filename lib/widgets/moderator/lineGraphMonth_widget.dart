import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class LineGraphMonthlyWidget extends StatefulWidget {
  final String selectedMonth;
  const LineGraphMonthlyWidget({super.key, required this.selectedMonth});

  @override
  State<LineGraphMonthlyWidget> createState() => _LineGraphMonthlyWidgetState();
}

class _LineGraphMonthlyWidgetState extends State<LineGraphMonthlyWidget> {
  late Map<double, double> _data1;
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  void didUpdateWidget(LineGraphMonthlyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedMonth != oldWidget.selectedMonth) {
      _updateData();
    }
  }

  void _updateData() {
    DateTime now = DateTime.now();
    int year = now.year;
    int monthIndex = months.indexOf(widget.selectedMonth);
    int daysInMonth = getDaysInMonth(year, monthIndex + 1);

    _data1 = generateRandomData(daysInMonth);
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    _updateData();
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
            show: false,
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
          tooltipBgColor: tcDark,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map(
              (LineBarSpot spot) {
                final flSpot = spot.bar.spots[spot.spotIndex];
                return LineTooltipItem(
                  flSpot.y.toString(),
                  TextStyle(color: tcWhite),
                );
              },
            ).toList();
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: tcLightViolet,
            dashArray: [5, 5],
          );
        },
      ),
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
              int dayOfMonth = val.toInt();

              int year = 2023;
              int month = 12;
              if (dayOfMonth <= DateTime(year, month + 1, 0).day) {
                return Text(
                  '$dayOfMonth',
                  style: TextStyle(color: tcBlack),
                );
              } else {
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

Map<double, double> generateRandomData(int daysInMonth) {
  final Map<double, double> data = {};
  final Random random = Random();

  for (int day = 1; day <= daysInMonth; day++) {
    data[day.toDouble()] = random.nextInt(100).toDouble();
  }

  return data;
}
