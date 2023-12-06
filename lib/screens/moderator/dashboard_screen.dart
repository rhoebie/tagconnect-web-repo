import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/models/type_model.dart';
import 'package:tagconnectweb/models/user_model.dart';
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
  bool isMonthly = false;
  List<UserModel>? users;

  double val1 = 0;
  double val2 = 0;
  double val3 = 0;
  double val4 = 0;

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

  double january = 0;
  double febuary = 0;
  double march = 0;
  double april = 0;
  double may = 0;
  double june = 0;
  double july = 0;
  double august = 0;
  double september = 0;
  double october = 0;
  double november = 0;
  double december = 0;

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
    return null;
  }

  Future<void> fetchYearly() async {
    try {
      final analyticService = AnalyticService();
      final YearlyModel fetchData = await analyticService.getYearlyReport(2023);

      int? jan = fetchData.month?['January'];
      int? feb = fetchData.month?['Febuary'];
      int? mar = fetchData.month?['March'];
      int? apr = fetchData.month?['April'];
      int? mayy = fetchData.month?['May'];
      int? jun = fetchData.month?['June'];
      int? jul = fetchData.month?['July'];
      int? aug = fetchData.month?['August'];
      int? sep = fetchData.month?['September'];
      int? oct = fetchData.month?['October'];
      int? nov = fetchData.month?['November'];
      int? dec = fetchData.month?['December'];

      setState(() {
        january = jan != null ? jan.toDouble() : 0;
        febuary = feb != null ? feb.toDouble() : 0;
        march = mar != null ? mar.toDouble() : 0;
        april = apr != null ? apr.toDouble() : 0;
        may = mayy != null ? mayy.toDouble() : 0;
        june = jun != null ? jun.toDouble() : 0;
        july = jul != null ? jul.toDouble() : 0;
        august = aug != null ? aug.toDouble() : 0;
        september = sep != null ? sep.toDouble() : 0;
        october = oct != null ? oct.toDouble() : 0;
        november = nov != null ? nov.toDouble() : 0;
        december = dec != null ? dec.toDouble() : 0;
      });
    } catch (e) {
      print('Error: $e');
    }
    return;
  }

  void fetchAll() {
    fetchUsers();
    fetchType();
    fetchYearly();
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
                                          child: LineGraphYearlyWidget(
                                              january: january,
                                              febuary: febuary,
                                              march: march,
                                              april: april,
                                              may: may,
                                              june: june,
                                              july: july,
                                              august: august,
                                              september: september,
                                              october: october,
                                              november: november,
                                              december: december))
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
                                    controller: _horizontalScrollController,
                                    child: SingleChildScrollView(
                                      controller: _horizontalScrollController,
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
                                        rows:
                                            (users ?? []).map((UserModel user) {
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
