import 'dart:developer';

import 'package:driver_app/Model/StudentListModel.dart';
import 'package:driver_app/Repository/home/StudentDetailListRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListController extends GetxController {
  var isLoadingClassList = false.obs;
  var isLoadingStudentList = false.obs;

  var list = <Result>[].obs;
  var stdcount = Rxn<StudentDetailListModel>();

  Future<void> getStudentList() async {
    try {
      isLoadingStudentList.value = true;

      final responses = await studentListRepository.fetchStudentList();
      if (responses.result != null) {
        log("transport ${responses.result}");

        list.value = responses.result!;

        stdcount.value = responses;
      } else {
        log('Error in getStudentList: ${responses.error}');
        list.value = [];
      }
    } catch (e) {
      log('Error in getStudentList: $e');
      list.value = [];
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        backgroundColor: Colors.red.shade400,
      );
    } finally {
      isLoadingStudentList.value = false;
    }
  }

  void sortListByName() {
    list.sort((a, b) {
      final nameComparison =
          a.fullName!.toLowerCase().compareTo(b.fullName!.toLowerCase());
      if (nameComparison != 0) {
        return nameComparison; // If names are different, use this result
      }
      return nameComparison;
    });
  }

  void sortListByLocation() {
    list.sort((a, b) {
      // // First compare by name

      final name = a.pickDropLocation?.busRoute!
          .toLowerCase()
          .compareTo(b.pickDropLocation!.busRoute!.toLowerCase());
      if (name != 0) {
        return name!; // If names are different, use this result
      }
      return name!;
    });
  }
}
