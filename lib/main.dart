import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/login_and_logout/login.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Check user authentication on app start
    auth();
  }

  // Method to check if user is authenticated and navigate accordingly
  void auth() async {
    bool isLoggedIn = await isAuthenticated();

    if (isLoggedIn) {
      // Navigate to the home page if user is logged in
      Get.offAll(() => const MainNavbar()); // Navigate to the main navbar
    } else {
      // Navigate to the login page if user is not logged in
      Get.off(() => DriverLoginScreen());
    }
  }

  // Simulated authentication check
  Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // Simulated method to retrieve authentication token
  Future<String?> getAuthToken() async {
    // Replace this with the actual implementation to retrieve the token
    // e.g., from SharedPreferences
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    return null; // Return token or null
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      // Display a loading screen initially
      home: const SplashScreen(),
    );
  }
}

// Splash screen widget while checking authentication
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show loading indicator
      ),
    );
  }
}
