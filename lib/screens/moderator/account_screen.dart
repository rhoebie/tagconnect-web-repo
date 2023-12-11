import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/models/user_model.dart';
import 'package:tagconnectweb/services/user_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  XFile? _image;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<UserModel?> fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // Initialize Service for User
      final userService = UserService();
      final userId = prefs.getInt('userId');

      if (userId != null) {
        final UserModel userData = await userService.getUserById(userId);
        setState(() {
          userModel = userData;
          _firstNameController.text = userData.firstname ?? '';
          _middleNameController.text = userData.middlename ?? '';
          _lastNameController.text = userData.lastname ?? '';
          _ageController.text = userData.age.toString();
          _birthdayController.text = userData.birthdate ?? '';
          _addressController.text = userData.address ?? '';
          _contactController.text = userData.contactnumber ?? '';
        });
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> updateUser(UserModel userdata) async {
    try {
      final userService = UserService();
      final response = await userService.patchUser(userdata);

      if (response) {
        return true;
      } else {
        print('Update Failed');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
    return false;
  }

  Future<String?> convertXFileToBase64(XFile? file) async {
    if (file == null) {
      return null;
    }

    final Uint8List uint8list = await File(file.path).readAsBytes();
    final buffer = uint8list.buffer.asUint8List();
    final base64String = base64Encode(buffer);
    return base64String;
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  void _takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (mounted) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  void onPressedIconWithText(UserModel userdata) {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(
          Duration(seconds: 1),
          () async {
            bool isSent = await updateUser(userdata);
            if (mounted) {
              setState(
                () {
                  stateTextWithIcon =
                      isSent ? ButtonState.success : ButtonState.fail;
                },
              );
            }
            if (isSent) {
              print('true');
            }
          },
        );
        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    if (mounted) {
      setState(
        () {
          stateTextWithIcon = stateTextWithIcon;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcAsh,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 700.w,
          height: 500.h,
          decoration: BoxDecoration(
            color: tcWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              color: tcAsh,
                              border: Border.all(
                                width: 1,
                                color: tcBlack,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: _image != null
                                  ? Image.file(
                                      File(_image!.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : userModel.image != null
                                      ? Image.network(
                                          userModel.image!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Icon(Icons.error);
                                          },
                                        )
                                      : Icon(
                                          Icons.question_mark,
                                          color: tcBlack,
                                          size: 50,
                                        ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.transparent,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () => setState(() {
                                    _takePhoto();
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tcAsh,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Camera',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PublicSans',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: tcBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Container(
                                width: 200.w,
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () => setState(() {
                                    _pickImage();
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tcAsh,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Gallery',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PublicSans',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: tcBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
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
                        validator: (value) => validateAge(value!),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
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
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_birthdayController.text.isNotEmpty) {
                                try {
                                  selectedDate =
                                      DateTime.parse(_birthdayController.text);
                                } catch (e) {
                                  print(
                                      'Invalid date format: ${_birthdayController.text}');
                                }
                              }

                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                if (mounted) {
                                  setState(() {
                                    selectedDate = pickedDate;

                                    // Format the selected date and set it to the dateController.text
                                    final formattedDate =
                                        DateFormat('yyyy/MM/dd')
                                            .format(pickedDate);
                                    _birthdayController.text = formattedDate;
                                  });
                                }
                              }
                            },
                            icon: Icon(Icons.calendar_month),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
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
                        validator: (value) => validatePhoneNumber(value!),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
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
                        validator: (value) => validateAddress(value!),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                ProgressButton.icon(
                  iconedButtons: {
                    ButtonState.idle: IconedButton(
                        text: 'Update',
                        icon: Icon(Icons.send, color: Colors.white),
                        color: tcViolet),
                    ButtonState.loading:
                        IconedButton(text: 'Loading', color: tcViolet),
                    ButtonState.fail: IconedButton(
                        text: 'Failed',
                        icon: Icon(Icons.cancel, color: Colors.white),
                        color: Colors.red.shade300),
                    ButtonState.success: IconedButton(
                        text: 'Success',
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        color: Colors.green.shade400)
                  },
                  onPressed: () async {
                    if (_image != null) {
                      final imageByte = await convertXFileToBase64(_image);
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        final data = UserModel(
                          firstname: _firstNameController.text,
                          middlename: _middleNameController.text,
                          lastname: _lastNameController.text,
                          age: int.parse(_ageController.text),
                          birthdate: _birthdayController.text,
                          contactnumber: _contactController.text,
                          address: _addressController.text,
                          image: imageByte.toString(),
                        );
                        onPressedIconWithText(data);
                      }
                    } else {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        final data = UserModel(
                          firstname: _firstNameController.text,
                          middlename: _middleNameController.text,
                          lastname: _lastNameController.text,
                          age: int.parse(_ageController.text),
                          birthdate: _birthdayController.text,
                          contactnumber: _contactController.text,
                          address: _addressController.text,
                          image: null,
                        );
                        onPressedIconWithText(data);
                      }
                    }
                  },
                  state: stateTextWithIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateName(String value) {
  if (value.isEmpty) {
    return 'Please enter your full name';
  }

  // Check if the name contains numbers
  if (RegExp(r'\d').hasMatch(value)) {
    return 'Name should not contain numbers';
  }

  return null; // Return null if the name is valid
}

String? validateAge(String value) {
  if (value.isEmpty) {
    return 'Please enter your age';
  }
  int age;
  try {
    age = int.parse(value);
    if (age < 0 || age > 120) {
      return 'Age should be between 0 and 120';
    }
  } catch (e) {
    return 'Age should be a valid number';
  }
  return null; // Return null if the age is valid
}

String? validateBirthdate(String value, int userAge) {
  if (value.isEmpty) {
    return 'Please enter your birthdate';
  }

  // Define a regular expression pattern to match the YYYY/MM/DD format
  const pattern = r'^\d{4}/(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return 'Birthdate should be in the YYYY/MM/DD format';
  }

  // Parse and validate the date using intl's DateFormat
  final dateFormat = DateFormat('yyyy/MM/dd');
  DateTime? date;
  try {
    date = dateFormat.parse(value);
  } catch (e) {
    return 'Invalid date';
  }

  // Calculate the expected birth year based on the user's age
  final today = DateTime.now();
  var expectedBirthYear = today.year - userAge;

  // Consider the cases where the birthday has not occurred yet
  if (today.month < date.month ||
      (today.month == date.month && today.day < date.day)) {
    expectedBirthYear--; // Decrease the expected year if the birthday hasn't occurred yet
  }

  // Ensure the birth year matches the user's age
  if (date.year != expectedBirthYear) {
    return 'Birth year should match your age';
  }

  return null; // Return null if the birthdate is valid
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Please enter your phone number';
  }

  if (value.startsWith('09') && value.length == 11) {
    return null; // Return null if the phone number is valid
  }

  return 'Invalid Format: 09 + 9 digits';
}

String? validateAddress(String value) {
  if (value.isEmpty) {
    return 'Please enter your address';
  }

  return null; // Return null if the address is valid
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter an email address';
  }

  // Use a regular expression to check if the input is in a valid email format
  final emailPattern =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');

  if (!emailPattern.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null; // Return null if the email is valid
}
