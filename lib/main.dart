import 'dart:async';

import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/firebase_options.dart';
import 'package:driver_app/screen/SplashScreen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(), // Wrap your app
    // ),

    const MyApp(), // Wrap your app
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   socketSetup.initSocket();
  //   notificationbloc.notificationdata();
  //   Timer.periodic(Duration(seconds: 1000), (timer) {
  //     notificationbloc.notificationdata();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
          shadowColor: Color(0xff435512)),
      home: SplashScreen(),
    );
  }
}
