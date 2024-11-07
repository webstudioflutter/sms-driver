import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/bill/bill_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        fontFamily: 'Lato',
        scaffoldBackgroundColor: const Color(0xffFEFEFE),
        useMaterial3: true,
      ),
      home: const BillMain(),
    );
  }
}
