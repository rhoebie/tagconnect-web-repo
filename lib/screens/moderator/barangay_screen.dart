import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/constant/color_constant.dart';

class BarangayScreen extends StatefulWidget {
  const BarangayScreen({super.key});

  @override
  State<BarangayScreen> createState() => _BarangayScreenState();
}

class _BarangayScreenState extends State<BarangayScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _middleNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _birthdayFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _contactFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 700.w,
          height: 800.h,
          decoration: BoxDecoration(
            color: tcWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BARANGAY INFORMATION',
                  textAlign: TextAlign.center,
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
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _firstNameController,
                  focusNode: _firstNameFocus,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _middleNameController,
                  focusNode: _middleNameFocus,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Middle Name',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _lastNameController,
                  focusNode: _lastNameFocus,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  focusNode: _ageFocus,
                  textAlign: TextAlign.start,
                  maxLength: 3,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: 'Age',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    hintText: 'Enter your age',
                    hintStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: tcGray,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: _birthdayController,
                  focusNode: _birthdayFocus,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    hintText: 'YYYY / MM / DD',
                    hintStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: tcGray,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _contactController,
                  focusNode: _contactFocus,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Contact',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    hintText: 'Enter your phonenumber',
                    hintStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: tcGray,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _addressController,
                  focusNode: _addressFocus,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: tcBlack,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,
                    hintText: 'Enter your address',
                    hintStyle: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: tcGray,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcBlack,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcViolet,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcRed,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: tcGray,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
