import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class LineGraphYearlyWidget extends StatefulWidget {
  final double january;
  final double febuary;
  final double march;
  final double april;
  final double may;
  final double june;
  final double july;
  final double august;
  final double september;
  final double october;
  final double november;
  final double december;
  const LineGraphYearlyWidget(
      {super.key,
      required this.january,
      required this.febuary,
      required this.march,
      required this.april,
      required this.may,
      required this.june,
      required this.july,
      required this.august,
      required this.september,
      required this.october,
      required this.november,
      required this.december});

  @override
  State<LineGraphYearlyWidget> createState() => _LineGraphYearlyWidgetState();
}

class _LineGraphYearlyWidgetState extends State<LineGraphYearlyWidget> {
  late Map<double, double> _data1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data1 = {
      1: widget.january,
      2: widget.febuary,
      3: widget.march,
      4: widget.april,
      5: widget.may,
      6: widget.june,
      7: widget.july,
      8: widget.august,
      9: widget.september,
      10: widget.october,
      11: widget.november,
      12: widget.december,
    };
  }

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
            getTitlesWidget: (double val, _) =>
                Text(DateFormat.MMM().format(DateTime(2023, val.toInt()))),
          ),
        ),
      ),
    );
    return LineChart(lineChartData);
  }
}
