import 'dart:developer';

import 'package:driver_app/Model/schoolsettingModel.dart';
import 'package:driver_app/Repository/schoosettingRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class schoolsettingController extends GetxController {
  var list = <Result>[].obs;

  Future<void> getSchoolSetting() async {
    try {
      final responses = await schoosettingrepository.settingData();
      if (responses.result != null) {
        log("transport ${responses.result}");

        list.value = responses.result!;
      } else {
        log('Error in getStudentList: ${responses.error}');
        list.value = [];
      }
    } catch (e) {
      log('Error in getStudentList: $e');
      list.value = [];
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red.shade400,
      );
    }
  }
}
