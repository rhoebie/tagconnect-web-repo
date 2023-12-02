import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Piechart extends StatefulWidget {
  const Piechart({super.key});

  @override
  State<Piechart> createState() => _PiechartState();
}

class _PiechartState extends State<Piechart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 90,
                  color: Colors.amber,
                  title: 'General',
                ),
                PieChartSectionData(
                  value: 100,
                  color: Colors.green,
                  title: 'Medical',
                ),
                PieChartSectionData(
                  value: 20,
                  color: Colors.red,
                  title: 'Fire',
                ),
                PieChartSectionData(
                  value: 500,
                  color: Colors.blue,
                  title: 'Crime',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
