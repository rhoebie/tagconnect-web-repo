import 'package:avatar_glow/avatar_glow.dart';
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
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TCONNECT',
                      textAlign: TextAlign.center,
                      style: taguigTheme.textTheme.titleMedium?.copyWith(
                        color: tcViolet,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                    ),
                    const Icon(
                      Icons.location_pin,
                      color: tcRed,
                      size: 30,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: tcWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'TCONNECT',
                            textAlign: TextAlign.center,
                            style: taguigTheme.textTheme.titleMedium?.copyWith(
                              color: tcViolet,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                            ),
                          ),
                          const Icon(
                            Icons.location_pin,
                            color: tcRed,
                            size: 30,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WELCOME',
                                style: taguigTheme.textTheme.headlineLarge
                                    ?.copyWith(
                                  color: tcBlack,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                'Sign in to continue.',
                                style:
                                    taguigTheme.textTheme.bodyMedium?.copyWith(
                                  color: tcBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
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
                                    labelStyle: taguigTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 16),
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
                                  color: tcWhite,
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
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: taguigTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                      fontSize: 16.sp,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 16),
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
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Forgot your password?',
                                        textAlign: TextAlign.center,
                                        style: taguigTheme.textTheme.labelMedium
                                            ?.copyWith(
                                          color: tcViolet,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200.w,
                            height: 120.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  loginUser(
                                      email: _emailController.text,
                                      password: _passwordController.text);

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              style: taguigTheme.elevatedButtonTheme.style,
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          tcWhite,
                                        ),
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: taguigTheme.textTheme.labelLarge
                                          ?.copyWith(
                                        color: tcWhite,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(),
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
