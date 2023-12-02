import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class PieGraphWidget extends StatefulWidget {
  final double val1;
  final double val2;
  final double val3;
  final double val4;
  const PieGraphWidget(
      {super.key,
      required this.val1,
      required this.val2,
      required this.val3,
      required this.val4});

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
            value: widget.val1,
            title: widget.val1.toString(),
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
            value: widget.val2,
            title: widget.val2.toString(),
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
            value: widget.val3,
            title: widget.val3.toString(),
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
            value: widget.val4,
            title: widget.val4.toString(),
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
