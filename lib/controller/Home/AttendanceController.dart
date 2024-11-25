import 'dart:developer';

import 'package:driver_app/Model/AttendanceModel.dart';
import 'package:driver_app/Repository/home/AttendanceRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final AttendanceRepository _repository = AttendanceRepository();
  var presentStudent = 0.obs;
  var absentStudent = 0.obs;
  var attendanceStatus = Map<String, dynamic>().obs;

  void markPresent() {
    presentStudent.value++;
  }

  void markAbsent() {
    absentStudent.value++;
  }

  var isLoading = false.obs;
  var attendanceModel = Rx<AttendanceModel?>(null);
  var sortParameter = ''.obs; // Sorting parameter

  Future<void> fetchStudentList() async {
    try {
      isLoading.value = true;

      final response = await _repository.fetchStudentList();

      if (response.count != null && response.count != 0) {
        attendanceModel.value = response; // Assign the response to the model
        sortAttendance(); // Sort data after fetching

        // Get.snackbar(
        //   'Success',
        //   'List fetched successfully!',
        //   backgroundColor: Colors.green.shade400,
        //   colorText: Colors.white,
        // );
      } else {
        attendanceModel.value = null;
        throw Exception('No data found');
      }
    } catch (e) {
      log('Error: $e');
      attendanceModel.value = null; // Reset model on error
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red.shade400,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void sortAttendance() {
    if (attendanceModel.value?.result == null) return;

    final data = attendanceModel.value!.result!;
    if (sortParameter.value == 'name') {
      data.sort((a, b) => (a.user?.name ?? '').compareTo(b.user?.name ?? ''));
    } else if (sortParameter.value == 'location') {
      data.sort((a, b) => (a.user?.pickDropLocation ?? '')
          .compareTo(b.user?.pickDropLocation ?? ''));
    }

    attendanceModel.refresh(); // Notify UI to update
  }

  @override
  void onInit() {
    super.onInit();
    fetchStudentList(); // Fetch data when the controller is initialized
  }
}
