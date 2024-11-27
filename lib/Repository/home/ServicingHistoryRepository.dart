import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/ServicingHistoryModel.dart';
import 'package:driver_app/controller/Auth/Basecontroller.dart';

class ServicingHistoryRepository {
  late final String _appUrl;
  late final Dio _dio;

  ServicingHistoryRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  Future<ServicingHistoryModel> fetchServicingHistory() async {
    try {
      final response = await _dio.get('$_appUrl/vehicle-expenses');
      log(response.data.toString());

      final servicingHistory = ServicingHistoryModel.fromJson(response.data);

      // Correct conditional check
      if (servicingHistory.count != 0 && servicingHistory.result?.length == 0) {
        return servicingHistory;
      } else {
        throw Exception("No data found");
      }
    } on DioException catch (error) {
      log('DioException: ${error.message}');
      return ServicingHistoryModel.withError(baseController.handleError(error));
    } catch (e) {
      log('Error: $e');
      return ServicingHistoryModel.withError(
        baseController.handleError("Unexpected error occurred"),
      );
    }
  }
}

final servicingHistoryRepo = ServicingHistoryRepository();
