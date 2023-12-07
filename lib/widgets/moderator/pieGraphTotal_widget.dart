import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class PieGraphWidget extends StatelessWidget {
  final double pie1;
  final double pie2;
  final double pie3;
  final double pie4;
  const PieGraphWidget({
    super.key,
    required this.pie1,
    required this.pie2,
    required this.pie3,
    required this.pie4,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: tcOrange,
            value: pie1,
            title: pie1.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100.r,
            titleStyle: TextStyle(
              color: tcOrange,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          PieChartSectionData(
            color: tcGreen,
            value: pie2,
            title: pie2.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100.r,
            titleStyle: TextStyle(
              color: tcGreen,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          PieChartSectionData(
            color: tcRed,
            value: pie3,
            title: pie3.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100.r,
            titleStyle: TextStyle(
              color: tcRed,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          PieChartSectionData(
            color: tcBlue,
            value: pie4,
            title: pie4.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100.r,
            titleStyle: TextStyle(
              color: tcBlue,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        borderData: FlBorderData(
          show: false,
        ),
        centerSpaceRadius: 0,
        sectionsSpace: 3,
      ),
    );
  }
}
