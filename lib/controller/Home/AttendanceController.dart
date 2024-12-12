import 'dart:developer';

import 'package:driver_app/Model/AttendanceModel.dart';
import 'package:driver_app/Repository/home/AttendanceRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final AttendanceRepository _repository = AttendanceRepository();
  var presentStudent = 0.obs;
  var absentStudent = 0.obs;
  var isLoading = false.obs;
  var attendanceModel = Rx<AttendanceModel?>(null);
  var sortParameter = ''.obs;
  Future<void> fetchStudentList() async {
    try {
      isLoading.value = true;
      final response = await _repository.fetchStudentList();
      if (response.count != null && response.count != 0) {
        attendanceModel.value = response; // Assign the response to the model
        sortAttendance(); // Sort data after fetching
      } else {
        attendanceModel.value = null;
        throw Exception('No data found');
      }
    } catch (e) {
      log('Error: $e');
      attendanceModel.value = null;
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red.shade400,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Updates the counts of present and absent students
  void updateCounts() {
    int present = 0;
    int absent = 0;

    for (var entry in attendanceModel.value?.result ?? []) {
      for (var contact in entry) {
        if (contact['status'] == true) present++;
        if (contact['status'] == false) absent++;
      }
    }
    presentStudent.value = present;
    absentStudent.value = absent;
  }

  // Updates the status of a specific student and adjusts the counts
  void updateStudentStatus(int index, bool isPresent) {
    attendanceModel.value?.result![index].status = isPresent;
    updateCounts();
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

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchStudentList(); // Fetch data when the controller is initialized
  // }
}
