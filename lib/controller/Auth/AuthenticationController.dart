import 'dart:developer';

import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final _secureStorage = const FlutterSecureStorage();
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email and Password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }
    var email =
        await _secureStorage.write(key: 'email', value: emailController.text);
    var password = await _secureStorage.write(
        key: 'password', value: passwordController.text);
    isLoading.value = true;
    try {
      final authData = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      await authenticationRepository.sendAuthInfo(authData);
    } catch (e) {
      log("Error: $e");
      Get.snackbar(
        "Error",
        "Invalid credentials",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
