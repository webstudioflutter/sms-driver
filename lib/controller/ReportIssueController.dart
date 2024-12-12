import 'dart:developer';

import 'package:driver_app/Repository/ReportIssueRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class vechileIssueController extends GetxController {
  var isLoading = false.obs;

  Future<void> postvechileIssue(Map<String, dynamic> datas) async {
    try {
      final responses = await reportIssuerepository.vechileIssue(datas);
      if (responses.result != null) {
        isLoading.value = true;
        log("transport ${responses.result}");
      } else {
        log('Error : ${responses.error}');
      }
    } catch (e) {
      log('Error : $e');
      Get.snackbar(
        'Error',
        'An error occurred',
        backgroundColor: Colors.red.shade400,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
