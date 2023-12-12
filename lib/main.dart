import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tagconnectweb/constant/color_constant.dart';
import 'package:tagconnectweb/constant/provider_constant.dart';
import 'package:tagconnectweb/firebase_options.dart';
import 'package:tagconnectweb/screens/moderator/splash_screen.dart';
import 'package:tagconnectweb/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApiService().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AutoLoginNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseMessaging.onMessage.listen((event) {
    //   if (event.notification == null) return;
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding: EdgeInsets.all(20),
    //           child: Column(
    //             children: [
    //               Text(
    //                 event.notification?.title ?? '',
    //                 style: TextStyle(
    //                   color: tcBlack,
    //                   fontFamily: 'Roboto',
    //                   fontSize: 18.sp,
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //               ),
    //               Divider(
    //                 color: Colors.transparent,
    //               ),
    //               Container(
    //                 width: 500,
    //                 child: Text(
    //                   event.notification?.body ?? '',
    //                   style: TextStyle(
    //                     color: tcBlack,
    //                     fontFamily: 'Roboto',
    //                     fontSize: 14.sp,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       });
    // });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'System',
          home: SplashScreen(),
        );
      },
    );
  }
}
