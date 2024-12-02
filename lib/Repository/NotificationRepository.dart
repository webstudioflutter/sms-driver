import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/NotificationModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Notificationrepopsitory {
  late final String appUrl;
  late final Dio _dio;

  Notificationrepopsitory() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<NotificationModel> NotificationData() async {
    try {
      String? stdID = await secureStorage.read(key: 'driverId');
      Response response = await _dio.get(
        '$appUrl/push-notification/user/$stdID',
      );

      return NotificationModel.fromJson(response.data);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      return NotificationModel.withError(baseController.handleError(error));
    }
  }

  Future<NotificationModel> updateNotificationData(String id) async {
    try {
      Response response = await _dio.patch(
        '$appUrl/push-notification/$id',
      );
      return NotificationModel.fromJson(response.data);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      return NotificationModel.withError(baseController.handleError(error));
    }
  }
}
