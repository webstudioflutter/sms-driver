import 'package:flutter/material.dart';

class AttendanceStatus extends StatelessWidget {
  const AttendanceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Present'),
          Text('Absent'),
        ],
      ),
    );
  }
}
