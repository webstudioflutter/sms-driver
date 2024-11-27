import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/controller/Auth/Basecontroller.dart';

class FuelTrackingRepository {
  late final String _appUrl;
  late final Dio _dio;

  FuelTrackingRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  Future<Map<String, dynamic>> postFuelTrackingInfo(
      Map<String, dynamic> fuelTrackingData) async {
    try {
      final response = await _dio.post(
        '$_appUrl/vehicle-fuel',
        data: fuelTrackingData,
      );

      if (response.data['message'] == "Success") {
        // Extract the result from the response
        final result = response.data['result'] as Map<String, dynamic>;
        return {
          'status': true,
          'message': "Data successfully submitted",
          'data': result,
        };
      } else {
        throw Exception("Failed to submit data");
      }
    } on DioException catch (error) {
      log('DioException: ${error.message}');
      return {
        'status': false,
        'message': "Failed to connect to the server: ${error.message}",
      };
    } catch (e) {
      log('Error: $e');
      return {
        'status': false,
        'message': "An unexpected error occurred: $e",
      };
    }
  }
}

final fuelTrackingRepository = FuelTrackingRepository();
