import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/ServicingHistoryModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServicingHistoryRepository {
  late final String _appUrl;
  late final Dio _dio;

  ServicingHistoryRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<ServicingHistoryModel> fetchServicingHistory() async {
    var transportationId = await _secureStorage.read(
      key: 'transportationId',
    );
    try {
      final response = await _dio
          .get('$_appUrl/vehicle-expenses/vehicle/676295ff3a54d833ca691dd7');

      final servicingHistory = ServicingHistoryModel.fromJson(response.data);

      if (servicingHistory.count != 0 && servicingHistory.result?.length != 0) {
        return servicingHistory;
      } else {
        throw Exception("No data found");
      }
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400) {
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
