import 'dart:developer';

import 'package:driver_app/Repository/home/FuelTrackingRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class FuelTrackingController extends GetxController {
  final FuelTrackingRepository _repository = FuelTrackingRepository();

  final TextEditingController odometerController = TextEditingController();
  final TextEditingController fuelRateController = TextEditingController();

  var fuelQuantity = 1.0.obs;
  var petrolPumpReadingReceipt = <Map<String, dynamic>>[].obs;

  var isLoading = false.obs;

  Future<void> submitFuelTrackingData() async {
    if (odometerController.text.isEmpty ||
        fuelRateController.text.isEmpty ||
        petrolPumpReadingReceipt.isEmpty) {
      Get.snackbar('Validation Error', 'Please fill all required fields.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    try {
      final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

      isLoading.value = true;

      final data = {
        "date": DateTime.now().toIso8601String().split('T').first,
        "readingOnOdometer": int.tryParse(odometerController.text) ?? 0,
        "addedFuel": fuelQuantity.value.toInt(),
        "fuelRate": int.tryParse(fuelRateController.text) ?? 0,
        "pumpReadingImage": petrolPumpReadingReceipt.first['fileName'],
        "driverInfo": {"_id": "driverId"}, // Replace with actual driver ID
        "vehicleInfo": {"_id": "vehicleId"}, // Replace with actual vehicle ID
      };

      final response = await _repository.postFuelTrackingInfo(data);

      if (response['status']) {
        Get.snackbar('Success', 'Fuel record added successfully!',
            backgroundColor: Colors.green.shade400, colorText: Colors.white);
        resetFields();
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      log('Error submitting fuel data: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.',
          backgroundColor: Colors.red.shade400);
    } finally {
      isLoading.value = false;
    }
  }

  void addFile(Map<String, dynamic> fileData) {
    petrolPumpReadingReceipt.add(fileData);
  }

  void resetFields() {
    odometerController.clear();
    fuelRateController.clear();
    fuelQuantity.value = 1.0;
    petrolPumpReadingReceipt.clear();
  }
}
