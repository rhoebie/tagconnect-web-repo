import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/widgets/moderator/linegraph.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('Dashboard'),
                            Container(
                              width: 480,
                              height: 300,
                              child: Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Card 1',
                                              style: TextStyle(fontSize: 24.0)),
                                          const SizedBox(height: 8.0),
                                          Text('Description for Card 1',
                                              style: TextStyle(fontSize: 16.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Card 2',
                                              style: TextStyle(fontSize: 24.0)),
                                          const SizedBox(height: 8.0),
                                          Text('Description for Card 2',
                                              style: TextStyle(fontSize: 16.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Card 3',
                                              style: TextStyle(fontSize: 24.0)),
                                          const SizedBox(height: 8.0),
                                          Text('Description for Card 3',
                                              style: TextStyle(fontSize: 16.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Card 4',
                                              style: TextStyle(fontSize: 24.0)),
                                          const SizedBox(height: 8.0),
                                          Text('Description for Card 4',
                                              style: TextStyle(fontSize: 16.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 700,
                              height: 700,
                              child: LineGraph(),
                            ),
                            Container(
                              width: 700,
                              height: 700,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text('ID'),
                                  ),
                                  DataColumn(
                                    label: Text('Barabgay ID'),
                                  ),
                                  DataColumn(
                                    label: Text('User ID'),
                                  ),
                                  DataColumn(
                                    label: Text('Location'),
                                  ),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(
                                      Text('112'),
                                    ),
                                    DataCell(
                                      Text('11212'),
                                    ),
                                    DataCell(
                                      Text('11212'),
                                    ),
                                    DataCell(
                                      Text('11212'),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
