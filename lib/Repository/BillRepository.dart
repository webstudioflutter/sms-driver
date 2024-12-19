import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/BillModel.dart';
import 'package:driver_app/Model/postBillModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BillRepository {
  late final Dio _dio;
  late final String appUrl;

  BillRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<BillModel> BillData() async {
    var id = await _secureStorage.read(key: 'schoolId');
    // var id = await _secureStorage.read(key: 'transportationId');

    try {
      Response response = await _dio.get('$appUrl/vehicle-expenses/school/$id');
      // Response response = await _dio.get('$appUrl//vehicle-expenses/vehicle/$id');

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

  Future<PostBillModel> patchBillDatas(
      String Id, Map<String, dynamic> data) async {
    try {
      Response response =
          await _dio.patch('$appUrl/vehicle-expenses/$Id', data: data);

      if (response.data != null) {
        log(" ${response.data}");
        return PostBillModel.fromJson(response.data);
      } else {
        log("Response data is null", name: 'BillRepository');
        return PostBillModel.withError("No data available");
      }
    } catch (error, stacktrace) {
      // Enhanced error logging
      log('Error occurred while fetching Bill data: $error\nStacktrace: $stacktrace',
          name: 'BillRepository');
      return PostBillModel.withError(baseController.handleError(error));
    }
  }
}

final billRepository = BillRepository();
