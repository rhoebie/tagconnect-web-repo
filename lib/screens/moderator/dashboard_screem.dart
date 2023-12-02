import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/widgets/moderator/barGraph_widget.dart';
import 'package:tagconnectweb/widgets/moderator/lineGraphMonth_widget.dart';
import 'package:tagconnectweb/widgets/moderator/pieGraph_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double val1 = 14.0;
  final double val2 = 8.0;
  final double val3 = 23.0;
  final double val4 = 17.0;
  int selectedYear = DateTime.now().year;

  Future<void> _selectYear(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: tcViolet,
            hintColor: tcViolet,
            colorScheme: ColorScheme.light(primary: tcViolet),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked.year != selectedYear) {
      setState(() {
        selectedYear = picked.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Rhoebie Jayriz C',
                      style: TextStyle(
                        color: tcBlack,
                        fontFamily: 'Roboto',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Hello',
                      style: TextStyle(
                        color: tcBlack,
                        fontFamily: 'Roboto',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: tcWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.notifications_rounded,
                            color: tcBlack,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.transparent,
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: tcWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: tcBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: tcWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Yearly Report',
                                      style: TextStyle(
                                        color: tcBlack,
                                        fontFamily: 'Roboto',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _selectYear(context),
                                      child: Text('Select Year: $selectedYear'),
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: LineGraphWidget(),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: tcWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Weekly Report',
                                            style: TextStyle(
                                              color: tcBlack,
                                              fontFamily: 'Roboto',
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: tcViolet,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'This Week',
                                                    style: TextStyle(
                                                      color: tcBlack,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: tcGray,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Last Week',
                                                    style: TextStyle(
                                                      color: tcBlack,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Expanded(
                                        child: BarGraphWidget(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: tcWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Counts',
                                            style: TextStyle(
                                              color: tcBlack,
                                              fontFamily: 'Roboto',
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: tcOrange,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'General',
                                                    style: TextStyle(
                                                      color: tcBlack,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                                width: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: tcGreen,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Medical',
                                                    style: TextStyle(
                                                      color: tcBlack,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                                width: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: tcRed,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Fire',
                                                    style: TextStyle(
                                                      color: tcBlack,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                                width: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: tcBlue,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Crime',
                                                    style: TextStyle(
                                                      color: tcBlack,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Expanded(
                                        child: PieGraphWidget(
                                          val1: val1,
                                          val2: val2,
                                          val3: val3,
                                          val4: val4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.transparent,
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: tcWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Feed Report',
                            style: TextStyle(
                              color: tcBlack,
                              fontFamily: 'Roboto',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: tcAsh,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: tcBlack,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                                icon: Icon(
                                  Icons.search,
                                  color: tcBlack,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 50,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Name $index'),
                                  subtitle: Text('Subtitle $index'),
                                  leading: Icon(Icons.person_rounded),
                                  onTap: () {
                                    // Handle item tap
                                    print('Tapped on item $index');
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
