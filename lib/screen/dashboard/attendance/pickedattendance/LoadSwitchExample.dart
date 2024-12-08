import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/dashboard/attendance/attendance.dart';
import 'package:driver_app/screen/dashboard/attendance/droppedattendance.dart';
import 'package:flutter/material.dart';
import 'package:load_switch/load_switch.dart';

class LoadSwitchExample extends StatefulWidget {
  @override
  _LoadSwitchExampleState createState() => _LoadSwitchExampleState();
}

class _LoadSwitchExampleState extends State<LoadSwitchExample> {
  bool isActive = true;

  Future<bool> _mockFuture() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating a delay
    return !isActive; // Simulate toggling the value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadSwitch(
              value: isActive,
              future: _mockFuture,
              style: SpinStyle.material,
              curveIn: Curves.easeInBack,
              curveOut: Curves.easeOutBack,
              animationDuration: const Duration(milliseconds: 500),
              switchDecoration: (value, isFocused) => BoxDecoration(
                color: value ? Colors.green[100] : Colors.red[100],
                borderRadius: BorderRadius.circular(30),
              ),
              spinColor: (value) => value
                  ? const Color.fromARGB(255, 41, 232, 31)
                  : const Color.fromARGB(255, 255, 77, 77),
              spinStrokeWidth: 3,
              thumbDecoration: (value, isFocused) => BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: value
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    spreadRadius: isFocused
                        ? 0.5
                        : 0.5, // Adjust shadow spread if focused
                    blurRadius: isFocused ? 1 : 1, // Adjust blur if focused
                    offset: const Offset(0.5, 0),
                  ),
                ],
              ),
              onChange: (v) {
                setState(() {
                  isActive = v;
                });
                print('Value changed to $v');
              },
              onTap: (v) {
                print('Tapping while value is $v');
              },
            ),
            SizedBox(height: 10),
            Text(
              "Switch is currently: ${isActive ? "PICKED" : "DROPPED"}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                authenticationRepository
                    .savepickdrop("${isActive ? "PICKED" : "DROPPED"}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          isActive ? Attendance() : DroppedAttendance()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withOpacity(0.5)
                      : Colors.red.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 50,
                width: 139,
                child: Center(
                  child: Text(
                    '${isActive ? "PICKED" : "DROPPED"}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
