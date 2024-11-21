// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/Authenticationmodel.dart';
import 'package:driver_app/controller/Auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  late final String _appUrl;
  late final Dio _dio;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthenticationRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  /// Sends authentication information to the server.
  Future<AuthenticationModel> sendAuthInfo(
      Map<String, dynamic> authData) async {
    try {
      final response = await _dio.post(
        '$_appUrl/user/login',
        data: authData,
      );

      final authResponse = AuthenticationModel.fromJson(response.data);

      // Validate response for DRIVER group and token
      if (authResponse.result?.group == "DRIVER" &&
          authResponse.token != null) {
        await _saveAuthToken(authResponse.token!);
        await _saveDriverId(authResponse.result!.id);
        await _saveSchoolId(authResponse.result!.username);
        await _saveTransportationId(authResponse.result!.transporation?.id);
      } else {
        throw Exception("Authentication failed");
      }

      return authResponse;
    } on DioException catch (error) {
      log('DioException: ${error.message}');
      return AuthenticationModel.withError(baseController.handleError(error));
    } catch (e) {
      log('Error: $e');
      return AuthenticationModel.withError(
          baseController.handleError("Unexpected error occurred"));
    }
  }

  /// Checks if the user is authenticated by validating the token.
  Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  /// Determines if this is the first time the user is using the app.
  Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstTimeUser') ?? true;
  }

  /// Saves driver ID to secure storage.
  Future<void> _saveDriverId(String? id) async {
    if (id != null) {
      await _secureStorage.write(key: 'driverId', value: id);
    }
  }

  /// Saves school ID to secure storage.
  Future<void> _saveSchoolId(String? id) async {
    if (id != null) {
      await _secureStorage.write(key: 'schoolId', value: id);
    }
  }

  /// Saves transportation ID to secure storage.
  Future<void> _saveTransportationId(String? id) async {
    if (id != null) {
      await _secureStorage.write(key: 'transportationId', value: id);
    }
  }

  /// Saves authentication token to shared preferences and sets `firstTimeUser` flag.
  Future<void> _saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstTimeUser', false);
    await prefs.setString('token', token);
  }

  /// Retrieves the authentication token from shared preferences.
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Logs the user out by clearing all stored data.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await _secureStorage.delete(key: 'driverId');
    await _secureStorage.delete(key: 'schoolId');
    await _secureStorage.delete(key: 'transportationId');
  }
}

final authenticationRepository = AuthenticationRepository();
