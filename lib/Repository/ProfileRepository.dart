import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/Authenticationmodel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

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
}

final profileRepository = ProfileRepository();
