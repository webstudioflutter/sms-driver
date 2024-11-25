// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:driver_app/Model/BillModel.dart';
// import 'package:driver_app/Repository/auth/Basecontroller.dart';

// class BillRepository {
//   late final String appUrl;
//   late final Dio _dio;
//   BillRepository() {
//     _dio = baseController.dio;
//     appUrl = baseController.appUrl;
//   }
//   Future<BillModel> BillData() async {
//     try {
//       Response response = await _dio.get(
//         '$appUrl/vehicle-expenses',
//       );
//       log("appUrl $response");
//       return BillModel.fromJson(response.data);
//     } catch (error, stacktrace) {
//       log('Exception occurred: $error stackTrace: $stacktrace');
//       return BillModel.withError(baseController.handleError(error));
//     }
//   }
// }

// final billRepository = BillRepository();

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/BillModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class BillRepository {
  late final Dio _dio;
  late final String appUrl;

  BillRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }

  Future<BillModel> BillData() async {
    try {
      // Sending a GET request to fetch vehicle expenses
      Response response =
          await _dio.get('$appUrl/vehicle-expenses/school/testflutter');

      // Check if the response is not empty and parse the data into a BillModel
      if (response.data != null) {
        log(" ${response.data}");
        return BillModel.fromJson(response.data);
      } else {
        log("Response data is null", name: 'BillRepository');
        return BillModel.withError("No data available");
      }
    } catch (error, stacktrace) {
      // Enhanced error logging
      log('Error occurred while fetching Bill data: $error\nStacktrace: $stacktrace',
          name: 'BillRepository');
      return BillModel.withError(baseController.handleError(error));
    }
  }

  postBillData(Map<String, dynamic> data) {}
}

final billRepository = BillRepository();
