import 'dart:developer';

import 'package:driver_app/Model/ClassListModel.dart';
import 'package:driver_app/Repository/home/ClassListRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class classListController extends GetxController {
  var isLoadingClassList = false.obs;
  var isLoadingStudentList = false.obs;

  // Observable class list model
  var classListModel = Rx<ClassListModel?>(null);

  Future<void> getClassList() async {
    try {
      isLoadingClassList.value = true;

      final response = await classListRepository.fetchClassList();

      // Check if the response has valid data, and assign it to the model.
      if (response.result != null && response.result!.isNotEmpty) {
        classListModel.value = response;
      } else {
        classListModel.value = null;
        log('No data found in class list');
      }
    } catch (e) {
      log('Error in getClassList: $e');
      classListModel.value = null;
      Get.snackbar(
        'Error',
        'An error occurred while fetching the class list. Please try again.',
        backgroundColor: Colors.red.shade400,
      );
    } finally {
      isLoadingClassList.value = false;
    }
  }
}


  // Future<void> getStudentList() async {
  //   try {
  //     isLoadingStudentList.value = true;

  //     final response = await studentListRepository.fetchStudentList();

  //     // Check if the response has valid data, and assign it to the model.
  //     if (response.count != null && response.result!.isNotEmpty) {
  //       studentListModel.value = response;
  //     } else {
  //       // Avoid throwing an error, just handle the empty case gracefully.
  //       studentListModel.value = null;
  //       log('No data found hai ta');
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //     studentListModel.value = null;
  //     Get.snackbar(
  //       'Error',
  //       'An error occurred. Please try again.',
  //       backgroundColor: Colors.red.shade400,
  //     );
  //   } finally {
  //     isLoadingStudentList.value = false;
  //   }
  // }

