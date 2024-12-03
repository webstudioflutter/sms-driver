import 'dart:developer';

import 'package:driver_app/Model/StudentListModel.dart';
import 'package:driver_app/Repository/home/StudentDetailListRepository.dart';
import 'package:get/get.dart';

class StudentListController extends GetxController {
  var isLoadingClassList = false.obs;
  var isLoadingStudentList = false.obs;

  var list = <Result>[].obs;
  var classdata = <ClassName>[].obs;
  var stdcount = Rxn<StudentDetailListModel>();
  Future<void> getStudentList() async {
    try {
      isLoadingStudentList.value = true;

      // Fetch data from the repository
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
      // Get.snackbar(
      //   'Error',
      //   'An error occurred. Please try again.',
      //   backgroundColor: Colors.red.shade400,
      // );
    } finally {
      isLoadingStudentList.value = false;
    }
  }
}
