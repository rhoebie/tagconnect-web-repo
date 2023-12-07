import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:flutter_map/flutter_map.dart' as map;
import 'package:tagconnectweb/models/report_model.dart';
import 'package:tagconnectweb/models/user_model.dart';
import 'package:tagconnectweb/services/report_service.dart';
import 'package:tagconnectweb/services/user_service.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  double selectedLatitude = 0.0;
  double selectedLongitude = 0.0;
  String selectedValue = "Submitted";
  late UserModel userModel = UserModel(
      firstname: '',
      lastname: '',
      age: 0,
      birthdate: '',
      contactnumber: '',
      address: '',
      image: '');

  Future<List<ReportModel>> fetchReport() async {
    try {
      final reportService = ReportService();
      final List<ReportModel> fetchReportData =
          await reportService.getReports();
      return fetchReportData;
    } catch (e) {
      print('Error fetching reportData: $e');
      throw e;
    }
  }

  Future<UserModel> fetchUser(int id) async {
    try {
      final userService = UserService();
      final UserModel fetchUserData = await userService.getUserById(id);
      setState(() {
        userModel = fetchUserData;
      });
      return fetchUserData;
    } catch (e) {
      print('Error fetching fetchUserData: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Container(
        padding: const EdgeInsets.all(20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Report Monitoring',
                        style: TextStyle(
                          color: tcBlack,
                          fontFamily: 'Roboto',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: fetchReport(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: tcViolet,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: tcGray,
                                  fontFamily: 'PublisSans',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final data = snapshot.data;
                            final filteredData =
                                filterDataByStatus(data!, selectedValue);

                            return Column(
                              children: [
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Overall Reports',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: tcBlack,
                                            fontFamily: 'Roboto',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          height: 10,
                                        ),
                                        Text(
                                          data.length.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: tcBlack,
                                            fontFamily: 'PublicSans',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Filter By',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: tcBlack,
                                            fontFamily: 'Roboto',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          child: DropdownButton<String>(
                                            value: selectedValue,
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: "Submitted",
                                                child: Text(
                                                  'Submitted',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: tcBlack,
                                                    fontFamily: 'PublicSans',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: "Processing",
                                                child: Text(
                                                  'Processing',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: tcBlack,
                                                    fontFamily: 'PublicSans',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: "Resolved",
                                                child: Text(
                                                  'Resolved',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: tcBlack,
                                                    fontFamily: 'PublicSans',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            onChanged: (String? newValue) {
                                              if (mounted) {
                                                setState(() {
                                                  selectedValue = newValue!;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: filteredData.length,
                                    itemBuilder: (context, index) {
                                      final item = filteredData[index];
                                      if (filteredData.isEmpty) {
                                        return Center(
                                          child: Text(
                                            'You dont have a pending report',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: tcGray,
                                              fontFamily: 'PublisSans',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ListTile(
                                          onTap: () async {
                                            await fetchUser(item.userId!);
                                            if (item.location!.latitude ==
                                                    null ||
                                                item.location!.longitude ==
                                                    null) {
                                              print('Location Null');
                                            } else {
                                              setState(() {
                                                selectedLatitude =
                                                    item.location!.latitude!;
                                                selectedLongitude =
                                                    item.location!.longitude!;
                                              });
                                            }
                                          },
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          title: Text(
                                            'Report ID: ${item.userId}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: tcBlack,
                                              fontFamily: 'PublisSans',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          subtitle: Text(
                                            formatCustomDateTime(
                                                item.createdAt.toString()),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: tcBlack,
                                              fontFamily: 'PublisSans',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No data available',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: tcGray,
                                  fontFamily: 'PublisSans',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.transparent,
              width: 20,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: tcWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          map.FlutterMap(
                            options: const map.MapOptions(
                                initialCenter: LatLng(
                                    14.522532114364807, 121.05956510721825),
                                initialZoom: 13),
                            children: [
                              map.TileLayer(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              ),
                              map.MarkerLayer(
                                markers: [
                                  map.Marker(
                                    alignment: Alignment.center,
                                    point: LatLng(
                                        selectedLatitude, selectedLongitude),
                                    child: Icon(
                                      Icons.location_on,
                                      color: tcRed,
                                      size: 60.r,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
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
                            child: ListView(
                              children: [
                                Text(
                                  'User Information',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontFamily: 'Roboto',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${userModel.lastname}, ${userModel.firstname} ${userModel.middlename}',
                                      style: TextStyle(
                                        color: tcBlack,
                                        fontFamily: 'PublicSans',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 5,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'PublicSans',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: tcBlack,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Account ID: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: userModel.id.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 5,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'PublicSans',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: tcBlack,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Role: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: userModel.roleId,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 30,
                                    ),
                                    Text(
                                      'Personal Information',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: tcBlack,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Birth Date',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: tcBlack,
                                                ),
                                              ),
                                              Text(
                                                userModel.birthdate.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: tcBlack,
                                                  fontFamily: 'PublicSans',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Age',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: tcBlack,
                                                ),
                                              ),
                                              Text(
                                                userModel.age.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: tcBlack,
                                                  fontFamily: 'PublicSans',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Address',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: tcBlack,
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  userModel.address ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: 'PublicSans',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: tcBlack,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 30,
                                    ),
                                    Text(
                                      'Contact Information',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: tcBlack,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Contact',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: tcBlack,
                                                ),
                                              ),
                                              Text(
                                                userModel.contactnumber ?? '',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: tcBlack,
                                                  fontFamily: 'PublicSans',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Email',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: tcBlack,
                                                ),
                                              ),
                                              Text(
                                                userModel.email ?? '',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: tcBlack,
                                                  fontFamily: 'PublicSans',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Status',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: tcBlack,
                                                ),
                                              ),
                                              Text(
                                                userModel.status ?? '',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: tcBlack,
                                                  fontFamily: 'PublicSans',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.transparent,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                          width: 20,
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
                                  'Report Information',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontFamily: 'Roboto',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
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
          ],
        ),
      ),
    );
  }
}

String calculateTimeInterval(DateTime dateTime1, DateTime dateTime2) {
  Duration difference = dateTime2.difference(dateTime1);
  int minutes = difference.inMinutes;
  int hours = difference.inHours % 24;
  int days = difference.inDays;

  String result = '';

  if (days > 0) {
    result += '${days} days ';
  }
  if (hours > 0) {
    result += '${hours} hours ';
  }
  if (minutes > 0) {
    result += '${minutes % 60} mins';
  }
  return result.trim();
}

List<ReportModel> filterDataByStatus(
    List<ReportModel> reports, String selectedValue) {
  if (selectedValue == "Submitted") {
    return reports.where((report) => report.status == 'Submitted').toList();
  } else if (selectedValue == "Processing") {
    return reports.where((report) => report.status == 'Processing').toList();
  } else if (selectedValue == "Resolved") {
    return reports.where((report) => report.status == 'Resolved').toList();
  }
  return reports;
}

String formatCustomDateTime(String input) {
  final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
  final dateTime = inputFormat.parse(input);

  // Updated output format
  final outputFormat = DateFormat("E, d MMM y hh:mma");
  final formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}
