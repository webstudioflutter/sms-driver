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
import 'package:driver_app/Repository/PostBillRepository.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class PostBillController extends GetxController {
  var postbill = Rxn<PostBillModel>();
  var isLoading = false.obs;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<void> postGetBills(Map<String, dynamic> data) async {
    isLoading.value = true;

    try {
      var Response = await postBillRepository.postBillData(data);

      if (Response.result != null) {
        log("bill data ${Response.result}");
        postbill.value = Response;
      } else {
        log("bill data ${Response.error}");
        postbill.value =
            PostBillModel.withError(baseController.handleError(Response.error));
      }
    } catch (e) {
      log("Error: $e");
      postbill.value = PostBillModel.withError(baseController.handleError(e));
    } finally {
      isLoading.value = false;
    }
  }
}

// Future<bool> postGetBills(Map<String, dynamic> data) async {
//   isLoading.value = true;

//   try {
//     // Make the API call to the repository to post the bill data
//     var response = await postBillRepository.postBillData(data);

//     if (response.result != null) {
//       // If response contains result, update the state
//       postbill.value = response;
//       log("PostBill data fetched: ${postbill.value}");

//       return true; // Return true if data was fetched successfully
//     } else {
//       // Handle case when no bills are returned or an error is encountered
//       log("No bills found or empty response");
//       postbill.value =
//           PostBillModel.withError(baseController.handleError(response.error));
//       return false; // Return false if no data found
//     }
//   } catch (e) {
//     // Handle unexpected errors
//     log("Error occurred while posting bill: $e");
//     postbill.value = PostBillModel.withError(baseController.handleError(e));
//     return false; // Return false in case of error
//   } finally {
//     // Set loading state to false once request is completed
//     isLoading.value = false;
//   }
// }

var postBillController = PostBillController();
