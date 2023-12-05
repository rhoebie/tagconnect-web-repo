import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/models/user_model.dart';
import 'package:tagconnectweb/widgets/moderator/barGraphWeek_widget.dart';
import 'package:tagconnectweb/widgets/moderator/lineGraphMonth_widget.dart';
import 'package:tagconnectweb/widgets/moderator/lineGraphYear_widget.dart';
import 'package:tagconnectweb/widgets/moderator/pieGraphTotal_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  late String selectedMonth;
  late String selectedYear;
  bool isMonthly = false;
  final List<UserModel> users = [
    UserModel(
      id: 1,
      roleId: 'user',
      firstname: 'John',
      lastname: 'Doe',
      age: 25,
      birthdate: '1998-05-15',
      contactnumber: '1234567890',
      address: '123 Main St, City',
      email: 'john.doe@example.com',
      image: null,
      status: 'Verified',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: 2,
      roleId: 'admin',
      firstname: 'Jane',
      lastname: 'Doe',
      age: 30,
      birthdate: '1992-08-20',
      contactnumber: '9876543210',
      address:
          'Block 121 Lot 11 Phase 8 Sitio Imelda Upper Bicutan Taguig City',
      email: 'jane.doe@example.com',
      image: null,
      status: 'Verified',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  double val1 = 14.0;
  double val2 = 8.0;
  double val3 = 23.0;
  double val4 = 17.0;

  double bar1_1 = 14.0;
  double bar1_2 = 5.0;
  double bar2_1 = 18.0;
  double bar2_2 = 28.0;
  double bar3_1 = 14.0;
  double bar3_2 = 18.0;
  double bar4_1 = 11.0;
  double bar4_2 = 8.0;
  double bar5_1 = 11.0;
  double bar5_2 = 8.0;
  double bar6_1 = 11.0;
  double bar6_2 = 8.0;
  double bar7_1 = 11.0;
  double bar7_2 = 8.0;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
    selectedYear = DateFormat('yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: tcBlack,
                    fontFamily: 'Roboto',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: tcWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.notifications_rounded,
                            color: tcBlack,
                            size: 30.r,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.transparent,
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: tcWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: tcBlack,
                            size: 30.r,
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
                    flex: 2,
                    child: Column(
                      children: [
                        isMonthly
                            ? Expanded(
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                              Row(
                                                children: [
                                                  Text(
                                                    'Current Selected Year: ',
                                                    style: TextStyle(
                                                      color: tcGray,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: selectedYear,
                                                    onChanged:
                                                        (String? newValue) {
                                                      if (newValue != null) {
                                                        setState(() {
                                                          selectedYear =
                                                              newValue;
                                                        });
                                                      }
                                                    },
                                                    items: [
                                                      '2020',
                                                      '2021',
                                                      '2022',
                                                      '2023',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            color: tcBlack,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isMonthly = !isMonthly;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Switch to Month ',
                                                  style: TextStyle(
                                                    color: tcBlack,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.swap_horiz_rounded,
                                                  color: tcBlack,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Expanded(
                                        child: LineGraphYearlyWidget(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Monthly Report',
                                                style: TextStyle(
                                                  color: tcBlack,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Current Selected Month: ',
                                                    style: TextStyle(
                                                      color: tcGray,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: selectedMonth,
                                                    onChanged:
                                                        (String? newValue) {
                                                      if (newValue != null) {
                                                        setState(() {
                                                          selectedMonth =
                                                              newValue;
                                                        });
                                                      }
                                                    },
                                                    items: [
                                                      'January',
                                                      'February',
                                                      'March',
                                                      'April',
                                                      'May',
                                                      'June',
                                                      'July',
                                                      'August',
                                                      'September',
                                                      'October',
                                                      'November',
                                                      'December',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            color: tcBlack,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  Text(
                                                    ' 2023',
                                                    style: TextStyle(
                                                      color: tcGray,
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
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isMonthly = !isMonthly;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Switch To Year ',
                                                  style: TextStyle(
                                                    color: tcBlack,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.swap_horiz_rounded,
                                                  color: tcBlack,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Expanded(
                                        child: LineGraphMonthlyWidget(
                                            selectedMonth: selectedMonth),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        Divider(
                          color: Colors.transparent,
                          height: 20,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Users Data',
                                      style: TextStyle(
                                        color: tcBlack,
                                        fontFamily: 'Roboto',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'This shows all the users that reported to your barangay',
                                      style: TextStyle(
                                        color: tcGray,
                                        fontFamily: 'Publicsans',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.transparent,
                                  height: 5,
                                ),
                                Expanded(
                                  child: Scrollbar(
                                    controller: _scrollController,
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columns: const <DataColumn>[
                                          DataColumn(
                                            label: Text('ID'),
                                          ),
                                          DataColumn(
                                            label: Text('Role ID'),
                                          ),
                                          DataColumn(
                                            label: Text('First Name'),
                                          ),
                                          DataColumn(
                                            label: Text('Middle Name'),
                                          ),
                                          DataColumn(
                                            label: Text('Last Name'),
                                          ),
                                          DataColumn(
                                            label: Text('Age'),
                                          ),
                                          DataColumn(
                                            label: Text('Birthdate'),
                                          ),
                                          DataColumn(
                                            label: Text('Contact Number'),
                                          ),
                                          DataColumn(
                                            label: Text('Address'),
                                          ),
                                          DataColumn(
                                            label: Text('Email'),
                                          ),
                                          DataColumn(
                                            label: Text('Image'),
                                          ),
                                          DataColumn(
                                            label: Text('Status'),
                                          )
                                        ],
                                        rows: users.map((UserModel user) {
                                          return DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(
                                                  user.id?.toString() ?? '')),
                                              DataCell(Text(user.roleId ?? '')),
                                              DataCell(
                                                  Text(user.firstname ?? '')),
                                              DataCell(
                                                  Text(user.middlename ?? '')),
                                              DataCell(
                                                  Text(user.lastname ?? '')),
                                              DataCell(Text(
                                                  user.age?.toString() ?? '')),
                                              DataCell(Text(
                                                  user.birthdate?.toString() ??
                                                      '')),
                                              DataCell(Text(user.contactnumber
                                                      ?.toString() ??
                                                  '')),
                                              DataCell(
                                                  Text(user.address ?? '')),
                                              DataCell(Text(user.email ?? '')),
                                              DataCell(Text(
                                                  user.image?.toString() ??
                                                      '')),
                                              DataCell(Text(user.status ?? '')),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.transparent,
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: tcViolet,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weekly Total Report',
                                    style: TextStyle(
                                      color: tcWhite,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                color: tcLightViolet,
                                                shape: BoxShape.circle),
                                          ),
                                          VerticalDivider(
                                            color: Colors.transparent,
                                            width: 5,
                                          ),
                                          Text(
                                            'This Week',
                                            style: TextStyle(
                                              color: tcWhite,
                                              fontFamily: 'Roboto',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
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
                                                color: tcDarkViolet,
                                                shape: BoxShape.circle),
                                          ),
                                          VerticalDivider(
                                            color: Colors.transparent,
                                            width: 5,
                                          ),
                                          Text(
                                            'Last Week',
                                            style: TextStyle(
                                              color: tcWhite,
                                              fontFamily: 'Roboto',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
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
                                child: BarGraphWidget(
                                  bar1_1: bar1_1,
                                  bar1_2: bar1_2,
                                  bar2_1: bar2_1,
                                  bar2_2: bar2_2,
                                  bar3_1: bar3_1,
                                  bar3_2: bar3_2,
                                  bar4_1: bar4_1,
                                  bar4_2: bar4_2,
                                  bar5_1: bar5_1,
                                  bar5_2: bar5_2,
                                  bar6_1: bar6_1,
                                  bar6_2: bar6_2,
                                  bar7_1: bar7_1,
                                  bar7_2: bar7_2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 20,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overall Total Report',
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
                                              fontWeight: FontWeight.w400,
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
                                              fontWeight: FontWeight.w400,
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
                                              fontWeight: FontWeight.w400,
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
                                              fontWeight: FontWeight.w400,
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
                                child: GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        val1 = 20;
                                        val2 = 35;
                                        val3 = 8;
                                        val4 = 12;
                                      });
                                    }
                                  },
                                  child: PieGraphWidget(
                                    pie1: val1,
                                    pie2: val2,
                                    pie3: val3,
                                    pie4: val4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
