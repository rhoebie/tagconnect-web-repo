import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/widgets/moderator/barGraph_widget.dart';
import 'package:tagconnectweb/widgets/moderator/lineGraph_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcWhite,
      body: SafeArea(
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dashboard',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'PublicSans',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w900,
                            color: tcDark,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Statistics',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'PublicSans',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: tcBlack,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        height: 450,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 20, right: 20, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: LineGraphWidget(),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 20, right: 20, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: BarGraphWidget(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Users Data',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'PublicSans',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: tcBlack,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
