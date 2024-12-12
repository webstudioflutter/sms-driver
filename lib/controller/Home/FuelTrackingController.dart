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
  // var petrolPumpReadingReceipt = <Map<String, dynamic>>[].obs;
  var petrolPumpReadingImage = <String>[].obs;

  var isLoading = false.obs;

  Future<void> submitFuelTrackingData() async {
    if (odometerController.text.isEmpty ||
        fuelRateController.text.isEmpty ||
        petrolPumpReadingImage.isEmpty) {
      Get.snackbar('Validation Error', 'Please fill all required fields.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    try {
      final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
      var schoolid = await _secureStorage.read(key: 'schoolId');
      var driverid = await _secureStorage.read(key: 'driverId');
      var drivername = await _secureStorage.read(key: 'drivername');
      var tranname = await _secureStorage.read(key: 'transporationName');
      var transId = await _secureStorage.read(key: 'transportationId');
      isLoading.value = true;

      final data = {
        "date": DateTime.now().toIso8601String().split('T').first,
        "readingOnOdometer": int.tryParse(odometerController.text) ?? 0,
        "addedFuel": fuelQuantity.value.toInt(),
        "fuelRate": int.tryParse(fuelRateController.text) ?? 0,
        // "pumpReadingImage": petrolPumpReadingReceipt.first['fileName'],
        "pumpReadingImage": petrolPumpReadingImage[0],
        "driverInfo": {"_id": "${driverid}", "name": "${drivername}"},
        "vehicleInfo": {"_id": "${transId}", "name": "${tranname}"},
        "status": true
      };
      log("Fuel Tracking Data:${data}");
      final response = await _repository.postFuelTrackingInfo(data);

      if (response['status']) {
        log(response['message'].toString());
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

  // void addFile(Map<String, dynamic> fileData) {
  //   petrolPumpReadingReceipt.add(fileData);
  // }

  void resetFields() {
    odometerController.clear();
    fuelRateController.clear();
    fuelQuantity.value = 1.0;
    petrolPumpReadingImage.clear();
  }
}
