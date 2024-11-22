import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MyApp(), // Wrap your app
      // ),

      const MyApp(), // Wrap your app
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // void checkLoginStatus() async {
  //   bool isLoggedIn = await authenticationRepository.isAuthenticated();
  //   if (isLoggedIn) {
  //     Get.to(() => const MainNavbar());
  //   } else {
  //     Get.to(() => DriverLoginScreen());
  //   }
  // }

  // Future<String?> getAuthToken() async {
  //   return null;
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
