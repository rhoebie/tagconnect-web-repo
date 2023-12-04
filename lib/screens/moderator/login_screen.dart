import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagconnectweb/configs/network_config.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/screens/admin/home_screen.dart' as home_admin;
import 'package:tagconnectweb/screens/moderator/home_screen.dart'
    as home_moderator;
import 'package:tagconnectweb/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _passwordVisible = false;
  bool isLoading = false;

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      bool isConnnected = await NetworkConfig.isConnected();
      if (isConnnected) {
        final authService = UserService();
        final role = await authService.login(email, password);

        if (role == 'Moderator') {
          _emailController.clear();
          _passwordController.clear();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const home_moderator.HomeScreen();
              },
            ),
          );
        } else if (role == 'Admin') {
          _emailController.clear();
          _passwordController.clear();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const home_admin.HomeScreen();
              },
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('No Internet'),
            content: const Text('Check your internet connection in settings'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: tcViolet,
                    ),
                    children: [
                      TextSpan(
                        text: 'TAG',
                      ),
                      TextSpan(
                        text: 'CONNECT ',
                      ),
                      TextSpan(
                        text: 'ADMIN',
                        style: TextStyle(
                          color: tcRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 400.w,
                  height: 350.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WELCOME',
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w900,
                          color: tcBlack,
                        ),
                      ),
                      Text(
                        'Sign in to continue.',
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: tcGray,
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              focusNode: _emailFocus,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: tcBlack,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address.';
                                } else if (!isValidEmail(value)) {
                                  return 'Please enter a valid email address.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontFamily: 'PublicSans',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: tcBlack,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 20,
                                ),
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
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              obscureText: !_passwordVisible,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: tcBlack,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password cannot be empty';
                                } else if (value.length < 6) {
                                  return 'Password should atleast 6 characters or more';
                                }
                                return null; // Return null if the input is valid
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontFamily: 'PublicSans',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: tcBlack,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                      print(_passwordVisible);
                                    });
                                  },
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: tcBlack,
                                    size: 20,
                                  ),
                                ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot your password?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PublicSans',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: tcViolet,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              await loginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tcViolet,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PublicSans',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: tcWhite,
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
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(email);
}
