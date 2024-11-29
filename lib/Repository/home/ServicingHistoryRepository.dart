import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/ServicingHistoryModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

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

      final servicingHistory = ServicingHistoryModel.fromJson(response.data);

      // Correct conditional check
      if (servicingHistory.count != 0 && servicingHistory.result?.length != 0) {
        return servicingHistory;
      } else {
        throw Exception("No data found");
      }
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400) {
        // Handle specific 400 status code
        final message = error.response?.data['message'] ?? "Bad Request";
        log("Log data (400): $message");

        return ServicingHistoryModel.withError(message);
      }
      return ServicingHistoryModel.withError(error.response?.data['message']);
    } catch (e) {
      log('Error: $e');
      return ServicingHistoryModel.withError(
        baseController.handleError("Unexpected error occurred"),
      );
    }
  }
}

final servicingHistoryRepo = ServicingHistoryRepository();
