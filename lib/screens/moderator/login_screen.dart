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
      backgroundColor: tcWhite,
      body: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              color: tcWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TagConnect: Act Swiftly, Support Securely',
                    style: TextStyle(
                      color: tcBlack,
                      fontFamily: 'Roboto',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: tcRed,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: tcBlack,
                              fontFamily: 'Roboto',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/incident.jpg',
              width: 1080,
              height: 1080,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(email);
}
