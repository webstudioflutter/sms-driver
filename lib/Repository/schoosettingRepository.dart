import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/schoolsettingModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Schoosettingrepository {
  late final Dio _dio;
  late final String appUrl;

  Schoosettingrepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }
  final _secureStorage = const FlutterSecureStorage();

  Future<SchoolsettingModel> settingData() async {
    var id = await _secureStorage.read(key: 'schoolId');

    try {
      Response response = await _dio.get('$appUrl/school-settings/$id');

      if (response.data != null) {
        log(" ${response.data}");
        return SchoolsettingModel.fromJson(response.data);
      } else {
        return SchoolsettingModel.withError("No data available");
      }
    } catch (error) {
      return SchoolsettingModel.withError(baseController.handleError(error));
    }
  }
}

final schoosettingrepository = Schoosettingrepository();
