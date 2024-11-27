// // import 'dart:developer';

// // import 'package:driver_app/Model/postBillModel.dart';
// // import 'package:driver_app/Repository/BillRepository.dart';
// // import 'package:driver_app/Repository/auth/Basecontroller.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:get/get.dart';

// // class PostBill {
// //   var postbill = Rxn<PostBillModel>();
// //   var isLoading = false.obs;

// //   Future<bool> postgetBills(Map<String, dynamic> data) async {
// //     isLoading.value = true;
// //     final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

// //     try {
// //       final Response = await billRepository.postBillData(data);

// //       if (Response.result != null) {
// //         postbill.value = Response;
// //       } else {
// //         log("No bills found or empty list");
// //         postbill.value =
// //             PostBillModel.withError(baseController.handleError(Response.error));
// //         ;
// //       }
// //     } catch (e) {
// //       log("Error: $e");
// //       postbill.value = PostBillModel.withError(baseController.handleError(e));
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// // }

// // var postBill = PostBill();

// import 'dart:developer';

// import 'package:driver_app/Model/postBillModel.dart';
// import 'package:driver_app/Repository/BillRepository.dart';
// import 'package:driver_app/Repository/auth/Basecontroller.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';

// class PostBill {
//   var postbill = Rxn<PostBillModel>();
//   var isLoading = false.obs;

//   Future<bool> postgetBills(Map<String, dynamic> data) async {
//     isLoading.value = true;
//     final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//     try {
//       final Response = await billRepository.postBillData(data);

//       if (Response.result != null) {
//         postbill.value = Response;
//         return true; // Return true if the bills were successfully fetched
//       } else {
//         log("No bills found or empty list");
//         postbill.value =
//             PostBillModel.withError(baseController.handleError(Response.error));
//         return false; // Return false if no bills found
//       }
//     } catch (e) {
//       log("Error: $e");
//       postbill.value = PostBillModel.withError(baseController.handleError(e));
//       return false; // Return false if an error occurred
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:developer';

import 'package:driver_app/Repository/BillRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../Repository/PostBillRepository.dart';

class PostBill extends GetxController {
  final PostBillRepository _repository = PostBillRepository();

  final TextEditingController billTypeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();

  var uploadedFiles = <Map<String, dynamic>>[].obs;

  var isLoading = false.obs;

  Future<void> submitFuelTrackingData() async {
    if (billTypeController.text.isEmpty ||
        dateController.text.isEmpty ||
        totalAmountController.text.isEmpty ||
        uploadedFiles.isEmpty) {
      Get.snackbar('Validation Error', 'Please fill all required fields.',
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    try {
      final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
      String? driverId = await _secureStorage.read(key: 'driverId');
      String? drivername = await _secureStorage.read(key: 'drivername');
      String? schoolname = await _secureStorage.read(key: 'schoolId');
      String? transportationId =
          await _secureStorage.read(key: 'transportationId');
      String? transporationName =
          await _secureStorage.read(key: 'transporationName');

      isLoading.value = true;

      final data = {
        // "date": DateTime.now().toIso8601String().split('T').first,
        // "readingOnOdometer": int.tryParse(billTypeController.text) ?? 0,
        // "addedFuel": fuelQuantity.value.toInt(),
        // "fuelRate": int.tryParse(dateController.text) ?? 0,
        // "pumpReadingImage": uploadedFiles.first['fileName'],
        // "driverInfo": {"_id": "driverId"}, // Replace with actual driver ID
        // "vehicleInfo": {"_id": "vehicleId"}, // Replace with actual vehicle ID

        "schoolId": schoolname,
        "date": DateTime.now().toIso8601String().split('T').first,

        "billType": int.tryParse(billTypeController.text),

        "billAmount": totalAmountController.value.toString(),

        "billImage": uploadedFiles.first['fileName'],

        "driverInfo": {"_id": driverId, "name": drivername},
        "vehicleInfo": {"_id": transportationId, "name": transporationName},
        "status": true
      };

      final response = await billRepository.postBillData(data);

      if (response['status']) {
        Get.snackbar('Success', 'Bill uploaded successfully!',
            backgroundColor: Colors.green.shade400, colorText: Colors.white);
        resetFields();
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      log('Error submitting bill data: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.',
          backgroundColor: Colors.red.shade400);
    } finally {
      isLoading.value = false;
    }
  }

  void addFile(Map<String, dynamic> fileData) {
    uploadedFiles.add(fileData);
  }

  void resetFields() {
    billTypeController.clear();
    dateController.clear();
    totalAmountController.clear();
    uploadedFiles.clear();
  }

  selectDate(BuildContext context) {}
}
