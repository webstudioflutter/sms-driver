import 'dart:developer';

import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController(text:"driver2@gmail.com");
  final passwordController = TextEditingController(text:"12345678");

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email and Password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      final authData = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      final authResponse =
          await authenticationRepository.sendAuthInfo(authData);
      if (authResponse.error == null) {
        log("${authResponse.result}");

        Get.offAll(() => const MainNavbar()); // Navigate to the main navbar
      } else {
        log("Login Failed");

        Get.snackbar(
          "Login Failed",
          authResponse.error!,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log("Error: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
