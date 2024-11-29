import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/Authenticationmodel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  late final String appUrl;
  late final Dio _dio;
  ProfileRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }
  Future<AuthenticationModel> ProfileData(String Id) async {
    try {
      Response response = await _dio.get(
        '$appUrl/user/$Id',
      );
      log("appUrl $response");
      return AuthenticationModel.fromJson(response.data);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      return AuthenticationModel.withError(baseController.handleError(error));
    }
  }

  Future<AuthenticationModel> updateProfileField(
      String Id, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      // Perform the PATCH request to update the profile field
      final response = await http.post(
        Uri.parse(
          '$appUrl/user/$Id',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(value),
      );
      // Response response = await _dio.patch(
      //   '$appUrl/user/$Id',
      //   data: value,
      // );

      if (response.statusCode == 200) {
        log("Success: ${response.body}");
        return AuthenticationModel.fromJson(json.decode(response.body));
      } else {
        log("Error response: ${response.statusCode} - ${response.body}");
        return AuthenticationModel.withError("Error: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      log('DioError: ${dioError.message}\nStacktrace: ${dioError.stackTrace}',
          name: 'ProfileRepository');
      return AuthenticationModel.withError(
          baseController.handleError(dioError));
    } catch (error, stacktrace) {
      log('Error: $error\nStacktrace: $stacktrace', name: 'ProfileRepository');
      return AuthenticationModel.withError(baseController.handleError(error));
    }
  }
}

var profileRepository = ProfileRepository();
