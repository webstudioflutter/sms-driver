import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/StartStopRoute.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class RouteRepository {
  late final String _appUrl;
  late final Dio _dio;

  RouteRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  Future<StartStopRoute> postRouteInfo(Map<String, dynamic> routeData) async {
    try {
      final response = await _dio.post(
        '$_appUrl/vehicle-startstop',
        data: routeData,
      );

      if (response.data['message'] == "Success") {
        // Extract the result from the response
        final result = response.data;
        return StartStopRoute.fromJson(result);
      } else {
        log("${Exception("Failed to submit data")}");
        throw Exception("Failed to submit data");
      }
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400 ||
          error.response?.statusCode == 500) {
        // Handle specific 400 status code
        final message = error.response?.data['message'] ?? "Bad Request";
        return StartStopRoute.withError("${message}");
      }
      log("Route ID: ${error.toString()}");
      // Re-throw any unhandled Dio errors
      rethrow;
    } catch (e) {
      return StartStopRoute.withError("${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> patchRouteInfo(
      String routeId, Map<String, dynamic> routeData) async {
    try {
      final response = await _dio.patch(
        '$_appUrl/vehicle-startstop/$routeId',
        data: routeData,
      );

      if (response.data['message'] == "Success") {
        // Extract the result from the response
        final result = response.data['result'] as Map<String, dynamic>;
        return {
          'status': true,
          'message': "Success",
          'data': result,
        };
      } else {
        throw Exception("Failed to submit data");
      }
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400 ||
          error.response?.statusCode == 500) {
        // Handle specific 400 status code
        final message = error.response?.data['message'] ?? "Bad Request";
        return {
          'status': false,
          'message': "${message}",
        };
      }
      // Re-throw any unhandled Dio errors
      rethrow;
    } catch (e) {
      return {
        'status': false,
        'message': "${e.toString()}",
      };
    }
  }
}

final routeRepository = RouteRepository();
