import 'dart:developer';

import 'package:driver_app/Model/BillModel.dart';
import 'package:driver_app/Repository/vechileAttendanceRepository.dart';
import 'package:get/get.dart';

class vechileAttendanceController extends GetxController {
  var isLoading = false.obs;
  var attendancedatas = Rxn<Result>();

  Future<bool> postvechileAttendance(Map<String, dynamic> postdatas) async {
    isLoading.value = true;

    try {
      final Response =
          await vechileattendanceRepository.AttendanceData(postdatas);

      if (Response.result != null) {
        log("${Response.result}");
        return true;
      } else {
        log("No bills found or empty list");
        return false;
      }
    } catch (e) {
      log("Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

var vechileattendanceController = vechileAttendanceController();
