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
//       } else {
//         log("No bills found or empty list");
//         postbill.value =
//             PostBillModel.withError(baseController.handleError(Response.error));
//         ;
//       }
//     } catch (e) {
//       log("Error: $e");
//       postbill.value = PostBillModel.withError(baseController.handleError(e));
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// var postBill = PostBill();

import 'dart:developer';

import 'package:driver_app/Model/postBillModel.dart';
import 'package:driver_app/Repository/BillRepository.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class PostBill {
  var postbill = Rxn<PostBillModel>();
  var isLoading = false.obs;

  Future<bool> postgetBills(Map<String, dynamic> data) async {
    isLoading.value = true;
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

    try {
      final Response = await billRepository.postBillData(data);

      if (Response.result != null) {
        postbill.value = Response;
        return true; // Return true if the bills were successfully fetched
      } else {
        log("No bills found or empty list");
        postbill.value =
            PostBillModel.withError(baseController.handleError(Response.error));
        return false; // Return false if no bills found
      }
    } catch (e) {
      log("Error: $e");
      postbill.value = PostBillModel.withError(baseController.handleError(e));
      return false; // Return false if an error occurred
    } finally {
      isLoading.value = false;
    }
  }
}
