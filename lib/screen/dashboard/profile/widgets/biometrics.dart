import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaceIdToggle extends StatefulWidget {
  @override
  _FaceIdToggleState createState() => _FaceIdToggleState();
}

class _FaceIdToggleState extends State<FaceIdToggle> {
  bool isBiometricEnabled = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _loadBiometricPreference();
  }

  // Load the saved preference
  Future<void> _loadBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBiometricEnabled =
          prefs.getBool('biomatric') ?? false; // Default to false
    });
  }

  // Authenticate user via biometric authentication
  Future<bool> _authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Please authenticate to log in with Fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      // Handle any errors or exceptions
      print('Error during authentication: $e');
      return false;
    }
  }

  // Toggle biometric authentication
  Future<void> _toggleBiometric(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value) {
      bool authenticated = await _authenticate();
      if (authenticated) {
        setState(() {
          isBiometricEnabled = true;
          prefs.setBool('biomatric', isBiometricEnabled);
        });
        Get.snackbar(
          'Success',
          'Biometric login enabled successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Authentication failed!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      setState(() {
        isBiometricEnabled = false;
        prefs.setBool('biomatric', isBiometricEnabled);
      });
      Get.snackbar(
        'Disabled',
        'Biometric login disabled.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/svg_images/lock.svg'),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'face_id'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'face_id_hint'.tr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isBiometricEnabled,
            onChanged: _toggleBiometric,
          ),
        ],
      ),
    );
  }
}
