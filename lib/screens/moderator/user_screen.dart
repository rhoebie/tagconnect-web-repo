import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/models/user_model.dart';
import 'package:tagconnectweb/services/user_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  List<UserModel>? users;
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

  @override
  void initState() {
    // TODO: implement initState
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 800.w,
          height: 500.h,
          decoration: BoxDecoration(
            color: tcWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'USERS INFORMATION',
                style: TextStyle(
                  color: tcBlack,
                  fontFamily: 'PublisSans',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Scrollbar(
                controller: _verticalScrollController,
                child: SingleChildScrollView(
                  controller: _verticalScrollController,
                  scrollDirection: Axis.vertical,
                  child: Scrollbar(
                    controller: _horizontalScrollController,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Role',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'First Name',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Middle Name',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Last Name',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Age',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Birthdate',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Contact Number',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Address',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Email',
                              style: TextStyle(
                                color: tcBlack,
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                        rows: (users ?? []).map((UserModel user) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text(
                                  user.id?.toString() ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.roleId ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.firstname ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.middlename ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.lastname ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.age?.toString() ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.birthdate?.toString() ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.contactnumber?.toString() ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.address ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.email ?? '',
                                  style: TextStyle(
                                    color: tcBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
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
