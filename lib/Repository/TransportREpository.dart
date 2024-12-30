import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/TransportModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransportRepository {
  Future<Transportation> transportdata(
      String? Id, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final _secureStorage = const FlutterSecureStorage();

    var token = prefs.getString('token');
    var id = await _secureStorage.read(key: 'transportationId');

    try {
      // Perform the PATCH request to update the profile field
      final response = await http.patch(
        Uri.parse(
          'http://62.72.42.129:8090/api/transportation-route/$id',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        log("Success: ${response.body}");
        return Transportation.fromJson(json.decode(response.body));
      } else {
        log("Error response: ${response.statusCode} - ${response.body}");
        return Transportation.withError("Error: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      log('DioError: ${dioError.message}\nStacktrace: ${dioError.stackTrace}',
          name: 'ProfileRepository');
      return Transportation.withError(baseController.handleError(dioError));
    } catch (error, stacktrace) {
      log('Error: $error\nStacktrace: $stacktrace', name: 'ProfileRepository');
      return Transportation.withError(baseController.handleError(error));
    }

    // try {
    //   Response response = await _dio.patch(
    //     'ws://62.72.42.129:8090/api/transportation-route/$Id',
    //     data: data,
    //   );
    //   log("mahesh ${response.data!}");

    //   return Transportation.fromJson(response.data);
    // } catch (error, stacktrace) {
    //   log('Exception occurred: $error stackTrace: $stacktrace');
    //   return Transportation.withError(baseController.handleError(error));
    // }
  }
}

final transportRepository = TransportRepository();
