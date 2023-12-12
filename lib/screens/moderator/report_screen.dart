import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:flutter_map/flutter_map.dart';
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
  bool isTileSelected = false;
  UserModel? userModel;
  ReportModel? reportModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<ReportModel>> fetchReport() async {
    try {
      final reportService = ReportService();
      final List<ReportModel> fetchReportData =
          await reportService.getReports();

      // Initialize selected field to false for each item
      for (var report in fetchReportData) {
        report.selected = false;
      }
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

  Future<void> processReport(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse('https://taguigconnect.online/api/moderator-update-process'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'reportId': id,
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }

        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> resolveReport(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse('https://taguigconnect.online/api/moderator-update-resolved'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'reportId': id,
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
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
                    width: 350.w,
                    height: 350.w,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: tcViolet, fontSize: 14.sp),
                  ),
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
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
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
                                                  userModel = null;
                                                  reportModel = null;
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
                                          selected: item.selected,
                                          selectedTileColor: tcViolet,
                                          onTap: () async {
                                            await fetchUser(item.userId!);
                                            setState(() {
                                              item.selected = !item.selected;

                                              if (item.selected) {
                                                reportModel = item;
                                                selectedLatitude =
                                                    item.location!.latitude!;
                                                selectedLongitude =
                                                    item.location!.longitude!;
                                              } else {
                                                // Handle deselection logic if needed
                                              }
                                            });
                                          },
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          title: Text(
                                            'Report ID: ${item.id}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            Container(
                              color: tcViolet,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Viewing Report ID: ${reportModel?.id ?? 'No Report Selected'}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: tcWhite,
                                  fontFamily: 'Roboto',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  FlutterMap(
                                    options: MapOptions(
                                        initialCenter: LatLng(
                                            14.496916262855029,
                                            121.0503352882308),
                                        initialZoom: 13),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            alignment: Alignment.center,
                                            point: LatLng(selectedLatitude,
                                                selectedLongitude),
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
                          ],
                        ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Text(
                                    'User Information',
                                    style: TextStyle(
                                      color: tcBlack,
                                      fontFamily: 'Roboto',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: ListView(
                                    children: [
                                      reportModel != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${userModel?.lastname ?? ''}, ${userModel?.firstname ?? ''} ${userModel?.middlename ?? ''}',
                                                          style: TextStyle(
                                                            color: tcBlack,
                                                            fontFamily:
                                                                'PublicSans',
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors
                                                              .transparent,
                                                          height: 5,
                                                        ),
                                                        RichText(
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Account ID: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: userModel
                                                                        ?.id
                                                                        .toString() ??
                                                                    '',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors
                                                              .transparent,
                                                          height: 5,
                                                        ),
                                                        RichText(
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: 'Role: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: userModel
                                                                        ?.roleId ??
                                                                    '',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 100.w,
                                                      height: 100.w,
                                                      child: ClipOval(
                                                        child:
                                                            userModel!.image !=
                                                                    null
                                                                ? InkWell(
                                                                    onTap: () {
                                                                      showImageDialog(
                                                                          context,
                                                                          userModel!
                                                                              .image);
                                                                    },
                                                                    child: Image
                                                                        .network(
                                                                      userModel!
                                                                          .image,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      loadingBuilder: (BuildContext context,
                                                                          Widget
                                                                              child,
                                                                          ImageChunkEvent?
                                                                              loadingProgress) {
                                                                        if (loadingProgress ==
                                                                            null) {
                                                                          return child;
                                                                        } else {
                                                                          return Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          );
                                                                        }
                                                                      },
                                                                      errorBuilder: (BuildContext context,
                                                                          Object
                                                                              error,
                                                                          StackTrace?
                                                                              stackTrace) {
                                                                        return Icon(
                                                                            Icons.error);
                                                                      },
                                                                    ),
                                                                  )
                                                                : Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .question_mark,
                                                                      size: 50,
                                                                      color:
                                                                          tcBlack,
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                  ],
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Birth Date',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                          ),
                                                          Text(
                                                            userModel?.birthdate
                                                                    .toString() ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: tcBlack,
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color:
                                                            Colors.transparent,
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Age',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                          ),
                                                          Text(
                                                            userModel?.age
                                                                    .toString() ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: tcBlack,
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color:
                                                            Colors.transparent,
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Address',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 150,
                                                            child: Text(
                                                              userModel
                                                                      ?.address ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'PublicSans',
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Contact',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                          ),
                                                          Text(
                                                            userModel
                                                                    ?.contactnumber ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: tcBlack,
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color:
                                                            Colors.transparent,
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Email',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                          ),
                                                          Text(
                                                            userModel?.email ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: tcBlack,
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color:
                                                            Colors.transparent,
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Status',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: tcBlack,
                                                            ),
                                                          ),
                                                          Text(
                                                            userModel?.status ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: tcBlack,
                                                              fontFamily:
                                                                  'PublicSans',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color:
                                                            Colors.transparent,
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ],
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        'Report Information',
                                        style: TextStyle(
                                          color: tcBlack,
                                          fontFamily: 'Roboto',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    selectedValue == 'Submitted'
                                        ? isLoading
                                            ? CircularProgressIndicator()
                                            : SizedBox(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (mounted) {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                    }
                                                    if (reportModel?.id !=
                                                        null) {
                                                      processReport(
                                                          reportModel!.id!);

                                                      reportModel = null;
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: tcGreen,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 2,
                                                  ),
                                                  child: Text(
                                                    'Process',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'PublicSans',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: tcWhite,
                                                    ),
                                                  ),
                                                ),
                                              )
                                        : selectedValue == 'Processing'
                                            ? isLoading
                                                ? CircularProgressIndicator()
                                                : SizedBox(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (mounted) {
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                        }
                                                        if (reportModel?.id !=
                                                            null) {
                                                          resolveReport(
                                                              reportModel!.id!);
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            tcGreen,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        elevation: 2,
                                                      ),
                                                      child: Text(
                                                        'Resolve',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'PublicSans',
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: tcWhite,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                            : Container(),
                                  ],
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: ListView(
                                    children: [
                                      reportModel != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Name: ${userModel?.lastname ?? ''}, ${userModel?.firstname ?? ''} ${userModel?.middlename ?? ''}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: tcBlack,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Date: ${formatCustomDateTime(reportModel?.createdAt.toString() ?? '')}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'PublicSans',
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: tcBlack,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 100.w,
                                                      height: 100.w,
                                                      child: ClipOval(
                                                        child: reportModel
                                                                    ?.image !=
                                                                null
                                                            ? InkWell(
                                                                onTap: () {
                                                                  showImageDialog(
                                                                      context,
                                                                      reportModel!
                                                                          .image!);
                                                                },
                                                                child: Image
                                                                    .network(
                                                                  reportModel!
                                                                      .image!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      return child;
                                                                    } else {
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      );
                                                                    }
                                                                  },
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          error,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return Icon(
                                                                        Icons
                                                                            .error);
                                                                  },
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .question_mark,
                                                                  size: 50,
                                                                  color:
                                                                      tcBlack,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Visibility',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel?.visibility ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Report ID',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel?.id
                                                              .toString() ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Barangay ID',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel?.barangayId
                                                              .toString() ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'For Whom?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel?.forWhom ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Any Casualties?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel?.casualties ==
                                                              1
                                                          ? 'Yes'
                                                          : 'No',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Status',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel?.status ?? '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Description',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                      reportModel
                                                              ?.description ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: tcBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
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
