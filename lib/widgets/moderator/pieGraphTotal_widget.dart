import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class PieGraphWidget extends StatefulWidget {
  final double pie1;
  final double pie2;
  final double pie3;
  final double pie4;
  const PieGraphWidget(
      {super.key,
      required this.pie1,
      required this.pie2,
      required this.pie3,
      required this.pie4});

  @override
  State<PieGraphWidget> createState() => _PieGraphWidgetState();
}

class _PieGraphWidgetState extends State<PieGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: tcOrange,
            value: widget.pie1,
            title: widget.pie1.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100,
            titleStyle: TextStyle(
              color: tcOrange,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          PieChartSectionData(
            color: tcGreen,
            value: widget.pie2,
            title: widget.pie2.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100,
            titleStyle: TextStyle(
              color: tcGreen,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          PieChartSectionData(
            color: tcRed,
            value: widget.pie3,
            title: widget.pie3.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100,
            titleStyle: TextStyle(
              color: tcRed,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          PieChartSectionData(
            color: tcBlue,
            value: widget.pie4,
            title: widget.pie4.toString(),
            titlePositionPercentageOffset: 1.3,
            radius: 100,
            titleStyle: TextStyle(
              color: tcBlue,
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
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
