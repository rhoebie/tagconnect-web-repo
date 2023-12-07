import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class LineGraphMonthlyWidget extends StatefulWidget {
  final Map<double, double> monthData;
  const LineGraphMonthlyWidget({super.key, required this.monthData});

  @override
  State<LineGraphMonthlyWidget> createState() => _LineGraphMonthlyWidgetState();
}

class _LineGraphMonthlyWidgetState extends State<LineGraphMonthlyWidget> {
  @override
  Widget build(BuildContext context) {
    final spots1 = <FlSpot>[
      for (final entry in widget.monthData.entries)
        FlSpot(entry.key, entry.value)
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
              if (widget.monthData.containsKey(val)) {
                return Text(
                  '${val.toInt()}',
                  style: TextStyle(color: tcBlack, fontSize: 14.sp),
                );
              }
              return Text('');
            },
          ),
        ),
      ),
    );
    return LineChart(lineChartData);
  }
}
