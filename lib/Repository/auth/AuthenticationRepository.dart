// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/Authenticationmodel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:driver_app/core/color_constant.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:driver_app/services/NotificationService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  late final String _appUrl;
  late final Dio _dio;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthenticationRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }
  Future<void> sendAuthInfo(Map<String, dynamic> authData) async {
    try {
      final response = await _dio.post(
        '$_appUrl/user/login',
        data: authData,
      );

      authResponse = AuthenticationModel.fromJson(response.data);
      if (authResponse!.result!.group == "DRIVER") {
        if (authResponse!.token != null) {
          await NotificationService.instance.initialize();
          await _saveAuthToken(authResponse!.token!);
          await _saveDriverId(authResponse!.result!.id);
          await _saveDrivename(authResponse!.result!.fullName);
          await _saveSchoolId(authResponse!.result!.username);
          await _saveTransportationId(authResponse!.result!.transporation?.id);
          await _saveTransportationName(
              authResponse!.result!.transporation!.name);

          Get.offAll(() => const MainNavbar());
        } else {
          throw Exception("You are not Driver??");
        }
      } else {
        throw Exception("Authentication failed");
      }
    } on DioException catch (error) {
      log('DioException: ${error.message}');
      // return AuthenticationModel.withError(baseController.handleError(error));
    } catch (e) {
      log('Error: $e');
      // return AuthenticationModel.withError(
      //     baseController.handleError("Unexpected error occurred"));
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
    bool? firstTimeUser = prefs.getBool('firstTimeUser');
    return firstTimeUser == null || firstTimeUser;
  }

  /// Saves driver ID to secure storage.
  Future<void> _saveDriverId(String? id) async {
    if (id != null) {
      await _secureStorage.write(key: 'driverId', value: id);
    }
  }

  Future<void> _saveDrivename(String? name) async {
    if (name != null) {
      await _secureStorage.write(key: 'drivername', value: name);
    }
  }

  /// Saves school ID to secure storage.
  Future<void> _saveSchoolId(String? id) async {
    if (id != null) {
      await _secureStorage.write(key: 'schoolId', value: id);
    }
  }

  Future<void> fcmtoken(String? token) async {
    if (token != null) {
      await _secureStorage.write(key: 'notificationtoken', value: token);
      String? fcmtokens = await _secureStorage.read(key: 'notificationtoken');
      // studentCardBloc.stdcardId(classId);
    }
  }

  /// Saves transportation ID to secure storage.
  Future<void> _saveTransportationId(String? id) async {
    if (id != null) {
      await _secureStorage.write(key: 'transportationId', value: id);
    }
  }

  Future<void> _saveTransportationName(String? name) async {
    if (name != null) {
      await _secureStorage.write(key: 'transporationName', value: name);
    }
  }

  Future<void> savepickdrop(String? name) async {
    if (name != null) {
      await _secureStorage.write(key: 'pickdrop', value: name);
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

  Future<void> deleteCurrentToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      log("mahesh token Token update empty");
    } catch (e) {
      print("Error deleting token: $e");
    }
  }

  /// Logs the user out by clearing all stored data.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    deleteCurrentToken();
    await _secureStorage.delete(key: 'notificationtoken');
    await _secureStorage.delete(key: 'driverId');
    await _secureStorage.delete(key: 'schoolId');
    await _secureStorage.delete(key: 'transportationId');
  }
}

final authenticationRepository = AuthenticationRepository();
