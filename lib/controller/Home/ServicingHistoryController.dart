import 'dart:developer';

import 'package:driver_app/Model/ServicingHistoryModel.dart';
import 'package:driver_app/Repository/home/ServicingHistoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicingHistoryController extends GetxController {
  final ServicingHistoryRepository _repository = ServicingHistoryRepository();

  var isLoading = false.obs;
  var servicingHistoryModel = Rx<ServicingHistoryModel?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchServicingHistoryList(); // Call the method during initialization
  }

  Future<void> fetchServicingHistoryList() async {
    try {
      isLoading.value = true;

      final response = await _repository.fetchServicingHistory();

      if (response.count != null && response.result != null) {
        servicingHistoryModel.value = response;
      } else {
        servicingHistoryModel.value = null;
        throw Exception('No data found');
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
