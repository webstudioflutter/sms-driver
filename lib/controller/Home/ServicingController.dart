import 'dart:developer';

import 'package:driver_app/Repository/home/ServicingRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ServicingController extends GetxController {
  final ServicingRepository _repository = ServicingRepository();

  var servicingDate = ''.obs;
  var partsUsed = <String>[].obs;
  final TextEditingController totalAmountController = TextEditingController();
  var billImage = <String>[].obs;
  var damagedPartImage = <String>[].obs;
  var replacedPartImage = <String>[].obs;

  var isLoading = false.obs;

  Future<void> submitServicingData() async {
    if (servicingDate.isEmpty ||
            totalAmountController.text.isEmpty ||
            billImage.isEmpty
        //partsUsed.isEmpty ||
        // damagedPartImage.isEmpty ||
        // replacedPartImage.isEmpty
        ) {
      Get.snackbar('Validation Error', 'Please fill required fields.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    try {
      final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

      isLoading.value = true;

      final data = {
        ///---------------Mandatory Properties---------------///
        "schoolId": "@nidisecondaryschool",
        "date": servicingDate.value,
        "billAmount": int.tryParse(totalAmountController.text) ?? 0,
        "expenseType": "Maintainance",
        "driverInfo": {"_id": "driverId"},
        "vehicleInfo": {"_id": "vehicleId"},

        ///---------------Optional Properties---------------///
        "partsUsed": partsUsed.toList(),
        // "billType": "Servicing",
        "billImage": billImage[0],
        "oldPartsImages": damagedPartImage.toList(),
        "newPartsImages": replacedPartImage.toList(),
        "status": true
      };
      log("Log servicing data:$data");
      final response = await _repository.postServicingData(servicingData: data);

      if (response['status']) {
        isLoading.value = false;

        log(response['message']);
        Get.snackbar('Success', 'Servicing record added successfully!',
            backgroundColor: Colors.green.shade400, colorText: Colors.white);

        resetFields();
      } else {
        Get.snackbar(
          'Error',
          response['message'],
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      log('Error submitting fuel data: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.',
          backgroundColor: Colors.red.shade400);
    } finally {
      isLoading.value = false;
    }
  }

  void resetFields() {
    totalAmountController.clear();
    partsUsed.toList().clear();
    billImage.toList().clear();
    damagedPartImage.toList().clear();
    replacedPartImage.toList().clear();
  }
}
