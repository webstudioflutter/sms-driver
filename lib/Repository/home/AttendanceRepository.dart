import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/AttendanceModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class AttendanceRepository {
  late final String _appUrl;
  late final Dio _dio;

  AttendanceRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  Future<AttendanceModel> fetchStudentList() async {
    try {
      final response = await _dio.get('$_appUrl/vehicle-attendance');

      final authResponse = AttendanceModel.fromJson(response.data);

      // Correct conditional check
      if (authResponse.count != null && authResponse.count != 0) {
        return authResponse;
      } else {
        throw Exception("No data found");
      }
    } on DioException catch (error) {
      log('DioException: ${error.message}');
      return AttendanceModel.withError(baseController.handleError(error));
    } catch (e) {
      log('Error: $e');
      return AttendanceModel.withError(
        baseController.handleError("Unexpected error occurred"),
      );
    }
  }
}

final fetchStudentListRepo = AttendanceRepository();
