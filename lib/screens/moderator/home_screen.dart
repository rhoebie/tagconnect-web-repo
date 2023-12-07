import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/constant/provider_constant.dart';
import 'package:tagconnectweb/models/barangay_model.dart';
import 'package:tagconnectweb/screens/moderator/account_screen.dart';
import 'package:tagconnectweb/screens/moderator/barangay_screen.dart';
import 'package:tagconnectweb/screens/moderator/dashboard_screen.dart';
import 'package:tagconnectweb/screens/moderator/report_screen.dart';
import 'package:tagconnectweb/screens/moderator/user_screen.dart';
import 'package:tagconnectweb/services/barangay_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool isDarkMode = false;

  Future<BarangayModel?> fetchBarangay() async {
    try {
      final barangayService = BarangayService();
      final BarangayModel fetchData = await barangayService.getbarangayInfo();
      return fetchData;
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final autoLoginNotifier = Provider.of<AutoLoginNotifier>(context);
    return Scaffold(
      backgroundColor: tcWhite,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                            future: fetchBarangay(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: tcViolet,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final barangayData = snapshot.data!;
                                return Text(
                                  barangayData.name ?? 'Barangay',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontFamily: 'PublicSans',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text('No data available'),
                                );
                              }
                            },
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'PublicSans',
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w900,
                                color: tcViolet,
                              ),
                              children: [
                                TextSpan(
                                  text: 'TAG',
                                ),
                                TextSpan(
                                  text: 'CONNECT',
                                  style: TextStyle(
                                    color: tcRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Moderator',
                            style: TextStyle(
                              color: tcBlack,
                              fontFamily: 'PublicSans',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Overview',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: tcBlack,
                        ),
                      ),
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      tileColor: _currentIndex != 0 ? tcWhite : tcAsh,
                      onTap: () {
                        _onItemTapped(0);
                      },
                      leading: Icon(
                        Icons.dashboard_rounded,
                        color: _currentIndex != 0 ? tcBlack : tcViolet,
                        size: 30.r,
                      ),
                      title: Text(
                        'Dashboard',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: _currentIndex != 0 ? tcBlack : tcViolet,
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      tileColor: _currentIndex != 1 ? tcWhite : tcAsh,
                      onTap: () {
                        _onItemTapped(1);
                      },
                      leading: Icon(
                        Icons.note_alt_rounded,
                        color: _currentIndex != 1 ? tcBlack : tcViolet,
                        size: 30.r,
                      ),
                      title: Text(
                        'Report',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: _currentIndex != 1 ? tcBlack : tcViolet,
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      tileColor: _currentIndex != 2 ? tcWhite : tcAsh,
                      onTap: () {
                        _onItemTapped(2);
                      },
                      leading: Icon(
                        Icons.home_rounded,
                        color: _currentIndex != 2 ? tcBlack : tcViolet,
                        size: 30.r,
                      ),
                      title: Text(
                        'Barangay',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: _currentIndex != 2 ? tcBlack : tcViolet,
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      tileColor: _currentIndex != 3 ? tcWhite : tcAsh,
                      onTap: () {
                        _onItemTapped(3);
                      },
                      leading: Icon(
                        Icons.person_rounded,
                        color: _currentIndex != 3 ? tcBlack : tcViolet,
                        size: 30.r,
                      ),
                      title: Text(
                        'Users',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: _currentIndex != 3 ? tcBlack : tcViolet,
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Account',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: tcBlack,
                        ),
                      ),
                    ),
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      tileColor: _currentIndex != 4 ? tcWhite : tcAsh,
                      onTap: () {
                        _onItemTapped(4);
                      },
                      leading: Icon(
                        Icons.person_rounded,
                        color: _currentIndex != 4 ? tcBlack : tcViolet,
                        size: 30.r,
                      ),
                      title: Text(
                        'Moderator',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: _currentIndex != 4 ? tcBlack : tcViolet,
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: tcBlack,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Auto Login',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: tcBlack,
                          ),
                        ),
                        Transform.scale(
                          scale: 1.r,
                          child: Switch(
                            value: autoLoginNotifier.isAutoLogin,
                            onChanged: (value) {
                              autoLoginNotifier.toggleLogin();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: tcBlack,
                          ),
                        ),
                        Transform.scale(
                          scale: 1.r,
                          child: Switch(
                            value: themeNotifier.isDarkMode,
                            onChanged: (value) {
                              themeNotifier.toggleTheme();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: PageView(
                controller: _pageController,
                children: [
                  DashboardScreen(),
                  ReportScreen(),
                  BarangayScreen(),
                  UserScreen(),
                  AccountScreen(),
                ],
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
