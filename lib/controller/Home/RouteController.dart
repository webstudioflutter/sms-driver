import 'dart:developer';

import 'package:driver_app/Repository/home/RouteRepository.dart';
import 'package:driver_app/screen/map/maps.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class Routecontroller extends GetxController {
  var isLoading = false.obs;
  final _secureStorage = const FlutterSecureStorage();

  Future<void> submitRouteData(Map<String, dynamic> data) async {
    try {
      final response = await routeRepository.postRouteInfo(data);
      isLoading.value = true;

      if (response.result != null) {
        var routeid = response.result!.id;
        await _secureStorage.write(key: 'routeid', value: routeid);
        log("Route ID: $routeid");

        Get.to(() => MapTrackingPage());
        Get.snackbar('Success', 'Request handled successfully!',
            backgroundColor: Colors.green.shade400, colorText: Colors.white);
      } else {
        log("message:${response.error}");
        Get.snackbar(
          'Error',
          response.message ?? "An error occurred",
          backgroundColor: Colors.red.shade300,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      log("message:${e}");

      Get.snackbar('Error', "An error occurred",
          backgroundColor: Colors.red.shade400);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> patchroutedata(Map<String, dynamic> data) async {
    try {
      final _secureStorage = const FlutterSecureStorage();

      isLoading.value = true;

      var id = await _secureStorage.read(key: 'routeid');

      final response = await routeRepository.patchRouteInfo(id!, data);

      if (response['message'] == "Success") {
        log("Route ID: ${response['data']}");
        Get.to(() => MainNavbar());

        Get.snackbar('Success', 'Updated successfully!',
            backgroundColor: Colors.green.shade400, colorText: Colors.white);
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
}
