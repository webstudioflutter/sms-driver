import 'dart:developer';

import 'package:driver_app/Repository/home/RouteController.dart';
import 'package:driver_app/screen/location/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class Routecontroller extends GetxController {
  final TextEditingController readingOnStartController =
      TextEditingController();
  final TextEditingController readingOnStopController = TextEditingController();
  var routeType = "".obs;

  var isLoading = false.obs;

  void submitRouteType(String value) {
    routeType.value = value;
  }

  Future<void> submitRouteData() async {
    if (readingOnStartController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Please fill required fields.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    try {
      final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

      isLoading.value = true;

      final data = {
        "schoolId": "@nidisecondaryschool", // Replace with dynamic value
        "date": DateTime.now().toIso8601String().split('T').first,
        "readingOnStart": int.tryParse(readingOnStartController.text) ?? 0,
        "readingOnStop": int.tryParse(readingOnStopController.text) ?? 0,
        "isPickedDrop": routeType.value,
        "driverInfo": {"_id": "driverId"}, // Replace with actual driver ID
        "vehicleInfo": {"_id": "vehicleId"}, // Replace with actual vehicle ID
      };
      log("Route Data:${data}");
      final response = await routeRepository.postRouteInfo(data);

      if (response['message'] == "Success") {
        Get.to(LiveTrackingMapPage());
        Get.snackbar('Success', 'Request handled successfully!',
            backgroundColor: Colors.green.shade400, colorText: Colors.white);
        resetFields();
      } else {
        Get.snackbar(
          'Error',
          response['message'],
          backgroundColor: Colors.red.shade300,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar('Error', "An error occurred",
          backgroundColor: Colors.red.shade400);
    } finally {
      isLoading.value = false;
    }
  }

  void resetFields() {
    readingOnStartController.clear();
    readingOnStopController.clear();
    routeType.value = '';
  }
}
