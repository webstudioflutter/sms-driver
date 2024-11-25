import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/postBillModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class PostBillRepository {
  late final Dio _dio;
  late final String appUrl;

  PostBillRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }

  Future<PostBillModel> postBillData(Map<String, dynamic> data) async {
    try {
      // Sending a GET request to fetch vehicle expenses
      Response response = await _dio.post(
        '$appUrl/vehicle-expenses',
        data: data,
      );

      // Check if the response is not empty and parse the data into a BillModel
      if (response.data != null) {
        log(" Success ${response.data}");
        return PostBillModel.fromJson(response.data);
      } else {
        log("Successmessage${response.statusMessage}");
        return PostBillModel.withError("${response.statusMessage}");
      }
    } catch (error, stacktrace) {
      // Enhanced error logging
      log('Error occurred while fetching Bill data: $error\nStacktrace: $stacktrace',
          name: 'PostBillRepository');
      return PostBillModel.withError(baseController.handleError(error));
    }
  }
}

final postBillRepository = PostBillRepository();
