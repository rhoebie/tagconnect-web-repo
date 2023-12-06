import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/models/monthly_model.dart';
import 'package:tagconnectweb/models/type_model.dart';
import 'package:tagconnectweb/models/user_model.dart';
import 'package:tagconnectweb/models/weekly_model.dart';
import 'package:tagconnectweb/models/yearly_model.dart';
import 'package:tagconnectweb/services/analytic_service.dart';
import 'package:tagconnectweb/services/user_service.dart';
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
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  late String selectedMonth;
  late String selectedYear;
  String thisDate = '';
  String lastDate = '';
  bool isMonthly = false;
  List<UserModel>? users;
  Map<double, double>? yearData;
  Map<double, double>? monthData;

  double val1 = 0;
  double val2 = 0;
  double val3 = 0;
  double val4 = 0;

  double bars1_1 = 0;
  double bars1_2 = 0;
  double bars2_1 = 0;
  double bars2_2 = 0;
  double bars3_1 = 0;
  double bars3_2 = 0;
  double bars4_1 = 0;
  double bars4_2 = 0;
  double bars5_1 = 0;
  double bars5_2 = 0;
  double bars6_1 = 0;
  double bars6_2 = 0;
  double bars7_1 = 0;
  double bars7_2 = 0;

  String _formatMap(Map<double, double> map) {
    return map.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(', ');
  }

  Future<void> fetchUsers() async {
    try {
      final userService = UserService();
      final List<UserModel>? fetchData = await userService.getAllUser();
      setState(() {
        users = fetchData;
      });
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  Future<void> fetchType() async {
    try {
      final analyticService = AnalyticService();
      final TypeModel fetchData = await analyticService.getTypeCount();
      setState(() {
        val1 = fetchData.general != null ? fetchData.general!.toDouble() : 0;
        val2 = fetchData.medical != null ? fetchData.medical!.toDouble() : 0;
        val3 = fetchData.fire != null ? fetchData.fire!.toDouble() : 0;
        val4 = fetchData.crime != null ? fetchData.crime!.toDouble() : 0;
      });
    } catch (e) {
      print('Error: $e');
    }
    return;
  }

  Future<void> fetchYearly(int year) async {
    try {
      final analyticService = AnalyticService();
      final YearlyModel fetchData = await analyticService.getYearlyReport(year);

      setState(() {
        yearData = {};

        fetchData.month?.forEach((String month, int value) {
          final monthNumber = DateFormat.MMMM().parse(month).month;
          yearData?[monthNumber.toDouble()] = value.toDouble();
        });
      });
    } catch (e) {
      print('Error: $e');
    }
    return;
  }

  Future<void> fetchMonthly(String month) async {
    try {
      final analyticService = AnalyticService();
      final MonthlyModel fetchData =
          await analyticService.getMonthlyReport(month);

      setState(() {
        monthData = {};
        fetchData.dates?.forEach((String date, int value) {
          monthData?[double.parse(date)] = value.toDouble();
        });
      });
    } catch (e) {
      print('Error: $e');
    }
    return;
  }

  Future<void> fetchWeekly() async {
    try {
      final analyticService = AnalyticService();
      final WeeklyModel fetchData = await analyticService.getWeeklyReport();

      setState(() {
        // Date
        thisDate = fetchData.thisDate ?? '';
        lastDate = fetchData.lastDate ?? '';
        // Sunday
        bars7_1 = fetchData.thisweek?.sunday?.toDouble() ?? 0.0;
        bars7_2 = fetchData.lastweek?.sunday?.toDouble() ?? 0.0;
        // Monday
        bars1_1 = fetchData.thisweek?.monday?.toDouble() ?? 0.0;
        bars1_2 = fetchData.lastweek?.monday?.toDouble() ?? 0.0;
        // Tuesday
        bars2_1 = fetchData.thisweek?.tuesday?.toDouble() ?? 0.0;
        bars2_2 = fetchData.lastweek?.tuesday?.toDouble() ?? 0.0;
        // Wednesday
        bars3_1 = fetchData.thisweek?.wednesday?.toDouble() ?? 0.0;
        bars3_2 = fetchData.lastweek?.wednesday?.toDouble() ?? 0.0;
        // Thursday
        bars4_1 = fetchData.thisweek?.thursday?.toDouble() ?? 0.0;
        bars4_2 = fetchData.lastweek?.thursday?.toDouble() ?? 0.0;
        // Friday
        bars5_1 = fetchData.thisweek?.friday?.toDouble() ?? 0.0;
        bars5_2 = fetchData.lastweek?.friday?.toDouble() ?? 0.0;
        // Saturday
        bars6_1 = fetchData.thisweek?.saturday?.toDouble() ?? 0.0;
        bars6_2 = fetchData.lastweek?.saturday?.toDouble() ?? 0.0;
      });
    } catch (e) {
      print('Error: $e');
    }
    return;
  }

  void fetchAll() async {
    await fetchUsers();
    await fetchType();
    await fetchYearly(int.parse(selectedYear));
    await fetchMonthly(selectedMonth.toLowerCase());
    await fetchWeekly();
  }

  @override
  void initState() {
    super.initState();
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
    selectedYear = DateFormat('yyyy').format(DateTime.now());
    fetchAll();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showImageDialog(BuildContext context, String imageUrl) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Image.network(
                    imageUrl,
                    width: 350,
                    height: 350,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      );
    }

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
                                                        fetchYearly(int.parse(
                                                            newValue));
                                                      }
                                                    },
                                                    items: [
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
                                        child: LineGraphYearlyWidget(
                                            yearData: yearData ?? {}),
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
                                                        fetchMonthly(newValue
                                                            .toLowerCase());
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
                                          monthData: monthData ?? {},
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
                                    controller: _verticalScrollController,
                                    child: SingleChildScrollView(
                                      controller: _verticalScrollController,
                                      scrollDirection: Axis.vertical,
                                      child: Scrollbar(
                                        controller: _horizontalScrollController,
                                        child: SingleChildScrollView(
                                          controller:
                                              _horizontalScrollController,
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            columns: const <DataColumn>[
                                              DataColumn(
                                                label: Text('ID'),
                                              ),
                                              DataColumn(
                                                label: Text('Role'),
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
                                            rows: (users ?? [])
                                                .map((UserModel user) {
                                              return DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text(
                                                      user.id?.toString() ??
                                                          '')),
                                                  DataCell(
                                                      Text(user.roleId ?? '')),
                                                  DataCell(Text(
                                                      user.firstname ?? '')),
                                                  DataCell(Text(
                                                      user.middlename ?? '')),
                                                  DataCell(Text(
                                                      user.lastname ?? '')),
                                                  DataCell(Text(
                                                      user.age?.toString() ??
                                                          '')),
                                                  DataCell(Text(user.birthdate
                                                          ?.toString() ??
                                                      '')),
                                                  DataCell(Text(user
                                                          .contactnumber
                                                          ?.toString() ??
                                                      '')),
                                                  DataCell(
                                                      Text(user.address ?? '')),
                                                  DataCell(
                                                      Text(user.email ?? '')),
                                                  // DataCell(user.image != null
                                                  //     ? InkWell(
                                                  //         onTap: () {
                                                  //           showImageDialog(
                                                  //               context,
                                                  //               user.image);
                                                  //         },
                                                  //         child: Text(
                                                  //           'View',
                                                  //           style: TextStyle(
                                                  //             color: tcViolet,
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     : Text('')),
                                                  DataCell(
                                                      Text(user.image ?? '')),
                                                  DataCell(
                                                      Text(user.status ?? '')),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
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
                                            'This Week: $thisDate',
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
                                            'Last Week: $lastDate',
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
                                  bar1_1: bars1_1,
                                  bar1_2: bars1_2,
                                  bar2_1: bars2_1,
                                  bar2_2: bars2_2,
                                  bar3_1: bars3_1,
                                  bar3_2: bars3_2,
                                  bar4_1: bars4_1,
                                  bar4_2: bars4_2,
                                  bar5_1: bars5_1,
                                  bar5_2: bars5_2,
                                  bar6_1: bars6_1,
                                  bar6_2: bars6_2,
                                  bar7_1: bars7_1,
                                  bar7_2: bars7_2,
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
                                child: PieGraphWidget(
                                  pie1: val1,
                                  pie2: val2,
                                  pie3: val3,
                                  pie4: val4,
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

class UserDataTableSource extends DataTableSource {
  final List<UserModel> _users;

  UserDataTableSource(this._users);

  @override
  DataRow? getRow(int index) {
    if (index >= _users.length) {
      return null;
    }
    final user = _users[index];

    return DataRow(
      cells: <DataCell>[
        DataCell(
          Text(
            user.id?.toString() ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.roleId ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.firstname ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.middlename ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.lastname ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.age?.toString() ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.birthdate?.toString() ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.contactnumber?.toString() ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.address ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.email ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.image?.toString() ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            user.status ?? '',
            style: TextStyle(
              color: tcBlack,
              fontFamily: 'PublicSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;
}
