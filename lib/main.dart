import 'dart:async';
import 'dart:developer';

import 'package:driver_app/controller/NotificationController.dart';
import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/SplashScreen/SplashScreen.dart';
import 'package:driver_app/services/NotificationService.dart';
import 'package:driver_app/services/socket_io_client.dart';
import 'package:driver_app/translate/localLanguage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    await Firebase.initializeApp();
    await NotificationService.instance.initialize();
  } catch (e) {
    log("Firebase initialization error: $e");
  }
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(), // Wrap your app
    // ),
    const MyApp(),
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
    socketSetup.initSocket();
    notificationbloc.notificationdata();
    Timer.periodic(Duration(seconds: 1000), (timer) {
      notificationbloc.notificationdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
          shadowColor: Color(0xff435512)),
      home: SplashScreen(),
    );
  }
}
