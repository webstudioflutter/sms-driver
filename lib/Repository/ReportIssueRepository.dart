import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/ReportIssueModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class ReportIssuerepository {
  late final Dio _dio;
  late final String appUrl;

  ReportIssuerepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }

  Future<ReportIssueModel> vechileIssue(Map<String, dynamic> datas) async {
    try {
      Response response = await _dio.post(
        '$appUrl/vehicle-issue',
        data: datas,
      );

      if (response.data != null) {
        log(" ${response.data}");
        return ReportIssueModel.fromJson(response.data);
      } else {
        log("error aayo");

        return ReportIssueModel.withError("No data available");
      }
    } catch (error) {
      log("error $error");
      return ReportIssueModel.withError(baseController.handleError(error));
    }
  }
}

final reportIssuerepository = ReportIssuerepository();
