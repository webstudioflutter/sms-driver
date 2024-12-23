import 'dart:async';
import 'dart:developer';

import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/SplashScreen/SplashScreen.dart';
import 'package:driver_app/services/NotificationService.dart';
import 'package:driver_app/translate/localLanguage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale? savedLocale;
  try {
    await Firebase.initializeApp();
    await NotificationService.instance.initialize();
    savedLocale = await _loadSavedLocale();
  } catch (e) {
    log("Firebase initialization error: $e");
  }
  runApp(MyApp(savedLocale: savedLocale));
}

class MyApp extends StatelessWidget {
  final Locale? savedLocale;

  const MyApp({super.key, this.savedLocale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          translations: LocalString(),
          locale: savedLocale ?? const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
            shadowColor: const Color(0xff435512),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

Future<Locale?> _loadSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('languageCode');
  final countryCode = prefs.getString('countryCode');

  if (languageCode != null) {
    return Locale(languageCode, countryCode);
  }
  return null;
}
