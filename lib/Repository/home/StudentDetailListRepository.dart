import 'package:dio/dio.dart';
import 'package:driver_app/Model/StudentListModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudentListRepository {
  late final String _appUrl;
  late final Dio _dio;

  StudentListRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<StudentDetailListModel> fetchStudentList() async {
    // Default empty map structure to return in case of no data

    var transportationId = await _secureStorage.read(
      key: 'transportationId',
    );

    try {
      // Make the API request
      final response = await _dio.get(
        // '$_appUrl/user/transportation/driver/$transportationId',
        '$_appUrl/user/transportation/676295ff3a54d833ca691dd7',
      );
      if (response.data != null) {
        return StudentDetailListModel.fromJson(response.data);
      } else {
        return StudentDetailListModel.withError(
            baseController.handleError(response.statusMessage));
      }
    } on DioException catch (error) {
      return StudentDetailListModel.withError(
          baseController.handleError(error));
    }
  }
}

final studentListRepository = StudentListRepository();
