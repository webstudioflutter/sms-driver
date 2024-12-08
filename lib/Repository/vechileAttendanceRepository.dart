import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/createAttandance.dart';
import 'package:driver_app/Model/updateAttandanceModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class vechileAttendanceRepository {
  late final Dio _dio;
  late final String appUrl;

  vechileAttendanceRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }

  Future<CreateAttandance> AttendanceData(Map<String, dynamic> datas) async {
    try {
      Response response = await _dio.post(
        '$appUrl/vehicle-attendance',
        data: datas,
      );

      if (response.data != null) {
        log(" ${response.data}");
        return CreateAttandance.fromJson(response.data);
      } else {
        return CreateAttandance.withError("No data available");
      }
    } catch (error) {
      return CreateAttandance.withError(baseController.handleError(error));
    }
  }

  Future<UpdateAttandanceModel> getDatabyprops(
      Map<String, dynamic> datas) async {
    try {
      final response = await _dio.post(
        '$appUrl/vehicle-attendance/props',
        data: datas,
      );
      if (response.data != null) {
        return UpdateAttandanceModel.fromJson(response.data);
      } else {
        return UpdateAttandanceModel.withError(
          baseController.handleError("Unexpected error occurred"),
        );
      }
    } catch (e) {
      log('Error: $e');
      return UpdateAttandanceModel.withError(
        baseController.handleError("Unexpected error occurred"),
      );
    }
  }

  Future<UpdateAttandanceModel> attendancepatch(
      String id, Map<String, dynamic> datas) async {
    try {
      final response = await _dio.patch(
        '$appUrl/vehicle-attendance/$id',
        data: datas,
      );
      if (response.data != null) {
        return UpdateAttandanceModel.fromJson(response.data);
      } else {
        return UpdateAttandanceModel.withError(
          baseController.handleError("Unexpected error occurred"),
        );
      }
    } catch (e) {
      log('Error: $e');
      return UpdateAttandanceModel.withError(
        baseController.handleError("Unexpected error occurred"),
      );
    }
  }
}

final vechileattendanceRepository = vechileAttendanceRepository();
