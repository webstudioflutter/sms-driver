import 'dart:developer';

import 'package:driver_app/Model/BillModel.dart';
import 'package:driver_app/Repository/BillRepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BillController extends GetxController {
  var isLoading = false.obs;
  var bills = <Result>[].obs;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<void> getBills() async {
    isLoading.value = true;

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

  Future<void> patchBills(String Id, Map<String, dynamic> data) async {
    isLoading.value = true;

    try {
      var Response = await billRepository.patchBillDatas(Id, data);

      if (Response.result != null) {
        log("${Response.result}");
      } else {
        log("No bills found or empty list");
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
