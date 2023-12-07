import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class LineGraphYearlyWidget extends StatelessWidget {
  final Map<double, double> yearData;
  const LineGraphYearlyWidget({super.key, required this.yearData});

  @override
  Widget build(BuildContext context) {
    final spots1 = <FlSpot>[
      for (final entry in yearData.entries) FlSpot(entry.key, entry.value)
    ];

    final lineChartData = LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots1,
          color: tcViolet,
          barWidth: 5.w,
          isCurved: false,
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
                  TextStyle(color: tcWhite, fontSize: 14.sp),
                );
              },
            ).toList();
          },
        ),
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
            getTitlesWidget: (double val, _) => Text(
              DateFormat.MMM().format(DateTime(2023, val.toInt())),
              style: TextStyle(color: tcBlack, fontSize: 14.sp),
            ),
          ),
        ),
      ),
    );
    return LineChart(lineChartData);
  }
}
