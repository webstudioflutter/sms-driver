import 'dart:developer';

import 'package:driver_app/Model/BillModel.dart';
import 'package:driver_app/Repository/BillRepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BillController extends GetxController {
  var isLoading = false.obs;
  var bills = <Result>[].obs;

  Future<void> getBills() async {
    isLoading.value = true;
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

    try {
      final Response = await billRepository.BillData();

      if (Response.result != null) {
        bills.value = Response.result!;
      } else {
        log("No bills found or empty list");
        bills.value = [];
      }
    } catch (e) {
      log("Error: $e");
      bills.value = [];
    } finally {
      isLoading.value = false;
    }
  }
}
