import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/TransportModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class TransportRepository {
  late final String appUrl;
  late final Dio _dio;

  TransportRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }

  Future<Transportation> transportdata(
      String? Id, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.patch(
        'http://62.72.42.129:8090/api/transportation-route/$Id',
        data: data,
      );
      log("mahesh ${response.data!}");

      return Transportation.fromJson(response.data);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      return Transportation.withError(baseController.handleError(error));
    }
  }
}

final transportRepository = TransportRepository();
