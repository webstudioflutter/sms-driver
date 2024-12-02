import 'package:dio/dio.dart';
import 'package:driver_app/Model/ClassListModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class ClassListRepository {
  late final String _appUrl;
  late final Dio _dio;

  ClassListRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  Future<ClassListModel> fetchClassList() async {
    try {
      final response = await _dio.get(
        '$_appUrl/classess/school/testflutter',
      );

      final classListResponse = ClassListModel.fromJson(response.data);
      if (classListResponse.result != null || classListResponse.count != null) {
        return classListResponse;
      } else {
        throw Exception("No data found");
      }
    } on DioException catch (error) {
      if (error.response != null && error.response?.statusCode == 400 ||
          error.response?.statusCode == 500) {
        // Handle specific 400 status code
        final message = error.response?.data['message'] ?? "Bad Request";

        return ClassListModel.withError(message);
      }
      // Re-throw any unhandled Dio errors
      rethrow;
    } catch (e) {
      return ClassListModel.withError(e.toString());
    }
  }
}

final classListRepository = ClassListRepository();