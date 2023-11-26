import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/screens/moderator/dashboard_screem.dart';
import 'package:tagconnectweb/screens/moderator/report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
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
                      Divider(
                        color: Colors.transparent,
                      ),
                      ListTile(
                        onTap: () {
                          _onItemTapped(0);
                        },
                        leading: Icon(
                          Icons.dashboard,
                          color: _currentIndex != 0 ? tcBlack : tcViolet,
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
                        onTap: () {
                          _onItemTapped(1);
                        },
                        leading: Icon(
                          Icons.notes,
                          color: _currentIndex != 1 ? tcBlack : tcViolet,
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
                      )
                    ],
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 7,
                child: PageView(
                  controller: _pageController,
                  children: [
                    DashboardScreen(),
                    ReportScreen(),
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
      ),
    );
  }
}
