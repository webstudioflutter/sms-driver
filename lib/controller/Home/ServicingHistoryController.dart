import 'dart:developer';

import 'package:driver_app/Model/ServicingHistoryModel.dart';
import 'package:driver_app/Repository/home/ServicingHistoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicingHistoryController extends GetxController {
  var isLoading = false.obs;
  var servicingHistoryModel = Rx<ServicingHistoryModel?>(null);

  Future<void> fetchServicingHistoryList() async {
    try {
      isLoading.value = true;

      final response = await servicingHistoryRepo.fetchServicingHistory();

      if (response.result != null && response.result!.isNotEmpty) {
        servicingHistoryModel.value = response;
      } else {
        servicingHistoryModel.value = null;
        log('No data found');
      }
    } catch (e) {
      log('Error: $e');
      servicingHistoryModel.value = null;
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red.shade400,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
