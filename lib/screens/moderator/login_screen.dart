import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:tagconnectweb/animations/fade_animation.dart';
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
  bool rememberMe = false;
  bool _passwordVisible = false;
  bool isLoading = false;
  String? userRole;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      bool isConnnected = await NetworkConfig.isConnected();
      if (isConnnected) {
        final authService = UserService();
        final role = await authService.login(email, password);

        if (role != null) {
          // if (rememberMe) {
          //   saveCredentials();
          // }
          print('User role: $role');
          _emailController.clear();
          _passwordController.clear();
          if (mounted) {
            setState(() {
              userRole = role;
            });
          }
          return true;
        } else {
          return false;
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
        return false;
      }
    } catch (e) {
      print('Error $e');
    }
    return false;
  }

  void onPressedIconWithText(
      {required String email, required String password}) {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(
          Duration(seconds: 1),
          () async {
            bool isLogin = await loginUser(email: email, password: password);
            if (mounted) {
              setState(
                () {
                  stateTextWithIcon =
                      isLogin ? ButtonState.success : ButtonState.fail;
                },
              );
            }

            if (userRole == 'Admin') {
              Future.delayed(
                Duration(seconds: 1),
                () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    FadeAnimation(const home_admin.HomeScreen()),
                    (route) => false,
                  );
                },
              );
            } else if (userRole == 'Moderator') {
              Future.delayed(
                Duration(seconds: 1),
                () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    FadeAnimation(const home_moderator.HomeScreen()),
                    (route) => false,
                  );
                },
              );
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
      backgroundColor: tcWhite,
      body: Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: tcViolet,
                    ),
                    children: const [
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
              ),
              Expanded(
                child: SizedBox(
                  width: 600.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
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
                                    return null;
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
                                        if (mounted) {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        }
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
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Checkbox(
                                          value: rememberMe,
                                          onChanged: (value) {
                                            if (mounted) {
                                              setState(() {
                                                rememberMe = value!;
                                              });
                                            }
                                          },
                                        ),
                                        Text('Remember Me'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: ProgressButton.icon(
                                iconedButtons: {
                                  ButtonState.idle: IconedButton(
                                      text: 'Login',
                                      icon: Icon(Icons.login,
                                          color: Colors.white),
                                      color: tcViolet),
                                  ButtonState.loading: IconedButton(
                                      text: 'Loading', color: tcViolet),
                                  ButtonState.fail: IconedButton(
                                      text: 'Failed',
                                      icon: Icon(Icons.cancel,
                                          color: Colors.white),
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
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    onPressedIconWithText(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                  }
                                },
                                state: stateTextWithIcon),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
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
