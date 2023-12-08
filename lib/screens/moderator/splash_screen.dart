import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagconnectweb/animations/fade_animation.dart';
import 'package:tagconnectweb/configs/network_config.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/constant/provider_constant.dart';
import 'package:tagconnectweb/models/credential_model.dart';
import 'package:tagconnectweb/screens/moderator/home_screen.dart';
import 'package:tagconnectweb/screens/moderator/login_screen.dart';
import 'package:tagconnectweb/services/user_service.dart';
import 'dart:html' as html;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AutoLoginNotifier autoLoginNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autoLoginNotifier = Provider.of<AutoLoginNotifier>(context, listen: false);
    loadSavedCredentials();
  }

  Future<void> loadSavedCredentials() async {
    try {
      // Retrieve JSON from local storage
      final jsonCredentials = html.window.localStorage['credentials'];

      if (jsonCredentials != null) {
        // Parse JSON into a CredentialModel instance
        final credentialModel =
            CredentialModel.fromJson(json.decode(jsonCredentials));
        // Set email and password from CredentialModel
        if (autoLoginNotifier.isAutoLogin) {
          print('Auto Login is True');
          Future.delayed(
            Duration(seconds: 1),
            () async {
              final response = await loginUser(
                email: credentialModel.email!,
                password: credentialModel.password!,
              );
              if (response) {
                print('Credentials Login Successful');
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    Navigator.of(context)
                        .pushReplacement(FadeAnimation(const HomeScreen()));
                  },
                );
              } else {
                print('Credentials Login Failed');
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    Navigator.of(context)
                        .pushReplacement(FadeAnimation(const LoginScreen()));
                  },
                );
              }
            },
          );
        } else {
          print('Auto Login is False');
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.of(context)
                  .pushReplacement(FadeAnimation(const LoginScreen()));
            },
          );
        }
      } else {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.of(context)
                .pushReplacement(FadeAnimation(const LoginScreen()));
          },
        );
        print('Credentials not found in local storage.');
      }
    } catch (e) {
      print('Error loading credentials: $e');
    }
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final tokenFcm = prefs.getString('fCMToken') ?? '';
      bool isConnnected = await NetworkConfig.isConnected();
      if (isConnnected) {
        final authService = UserService();
        final token = await authService.login(email, password, tokenFcm);

        if (token != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcWhite,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_pin,
                  color: tcRed,
                  size: 50,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
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
                Container(
                  width: 250.w,
                  child: Text(
                    'An efficient incident reporting and analytics system for Taguig City',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PublicSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: tcGray,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                const CircularProgressIndicator(
                  color: tcViolet,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
