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
    if (totalAmountController.text.isEmpty ||
            servicingDate.isEmpty ||
            partsUsed.isEmpty ||
            billImage.isEmpty
        //||
        // damagedPartImage.isEmpty ||
        // replacedPartImage.isEmpty
        ) {
      Get.snackbar('Validation Error', 'Please fill all required fields.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    try {
      final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

      isLoading.value = true;

      final data = {
        "date": servicingDate.value,
        "partsUsed": partsUsed.toList(),
        "billAmount": int.tryParse(totalAmountController.text) ?? 0,
        "billType": "Servicing",
        "billImage": billImage[0],
        "oldPartsImages": damagedPartImage.toList(),
        "newPartsImages": replacedPartImage.toList(),
        "driverInfo": {"_id": "driverId"},
        "vehicleInfo": {"_id": "vehicleId"},
        "status": true
      };
      final response = await _repository.postServicingData(servicingData: data);

      if (response['status']) {
        isLoading.value = false;

        log(response['message']);
        Get.snackbar('Success', 'Servicing record added successfully!',
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

  void resetFields() {
    totalAmountController.clear();
    partsUsed.toList().clear();
    billImage.toList().clear();
    damagedPartImage.toList().clear();
    replacedPartImage.toList().clear();
  }
}
