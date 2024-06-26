import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class BarGraphWidget extends StatefulWidget {
  final double bar1_1;
  final double bar1_2;
  final double bar2_1;
  final double bar2_2;
  final double bar3_1;
  final double bar3_2;
  final double bar4_1;
  final double bar4_2;
  final double bar5_1;
  final double bar5_2;
  final double bar6_1;
  final double bar6_2;
  final double bar7_1;
  final double bar7_2;
  const BarGraphWidget(
      {super.key,
      required this.bar1_1,
      required this.bar1_2,
      required this.bar2_1,
      required this.bar2_2,
      required this.bar3_1,
      required this.bar3_2,
      required this.bar4_1,
      required this.bar4_2,
      required this.bar5_1,
      required this.bar5_2,
      required this.bar6_1,
      required this.bar6_2,
      required this.bar7_1,
      required this.bar7_2});

  @override
  State<BarGraphWidget> createState() => _BarGraphWidgetState();
}

class _BarGraphWidgetState extends State<BarGraphWidget> {
  double barWidth = 15;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                  toY: widget.bar7_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar7_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                  toY: widget.bar1_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar1_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                  toY: widget.bar2_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar2_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                  toY: widget.bar3_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar3_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                  toY: widget.bar4_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar4_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                  toY: widget.bar5_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar5_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
          BarChartGroupData(
            x: 6,
            barRods: [
              BarChartRodData(
                  toY: widget.bar6_1, color: tcLightViolet, width: barWidth.w),
              BarChartRodData(
                  toY: widget.bar6_2, color: tcDarkViolet, width: barWidth.w),
            ],
            barsSpace: 5.0,
          ),
        ],
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: tcDark,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String value = rod.toY.toString();
              return BarTooltipItem(
                value,
                TextStyle(color: tcWhite, fontSize: 14.sp),
              );
            },
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: tcWhite,
              dashArray: [5, 5],
            );
          },
        ),
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
                    return Text(
                      'Sun',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  case 1:
                    return Text(
                      'Mon',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  case 2:
                    return Text(
                      'Tue',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  case 3:
                    return Text(
                      'Wed',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  case 4:
                    return Text(
                      'Thu',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  case 5:
                    return Text(
                      'Fri',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  case 6:
                    return Text(
                      'Sat',
                      style: TextStyle(color: tcWhite, fontSize: 14.sp),
                    );
                  default:
                    return Text('');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
