import 'dart:developer';

import 'package:driver_app/Repository/home/RouteController.dart';
import 'package:driver_app/screen/map/maps.dart';
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
      var schoolid = await _secureStorage.read(key: 'schoolId');
      var driverid = await _secureStorage.read(key: 'driverId');
      var drivername = await _secureStorage.read(key: 'drivername');
      var tranname = await _secureStorage.read(key: 'transporationName');
      var transId = await _secureStorage.read(key: 'transportationId');
      isLoading.value = true;

      final data = {
        "schoolId": "$schoolid", // Replace with dynamic value
        "date": DateTime.now().toIso8601String().split('T').first,
        "readingOnStart": int.parse(readingOnStartController.text) ?? 0,
        "readingOnStop": 0,
        "isPickedDrop": routeType.value,
        "driverInfo": {"_id": "${driverid}", "name": "${drivername}"},
        "vehicleInfo": {"_id": "${transId}", "name": "${tranname}"},
      };
      log("Route Data:${data}");
      final response = await routeRepository.postRouteInfo(data);

      if (response['message'] == "Success") {
        Get.to(MapTrackingPage());
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
