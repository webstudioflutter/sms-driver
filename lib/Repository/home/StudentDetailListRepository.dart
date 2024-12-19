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
        // '$_appUrl/user/transportation/$transportationId',
        '$_appUrl/user/transportation/676295ff3a54d833ca691dd7',
      );

      // Check if 'count' field exists and is non-zero in the response
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

//   Future<StudentDetailListModel> fetchStudentDummyList() async {
//     try {
//       final response = await _dio.get(
//         '$_appUrl/user/transportation/67189289a610cd23428ebc55',
//       );
//       // log('res: ${response.data}');
//       final data = (response.data['result'] as List)
//           .map((e) => Result.fromJson(e))
//           .toList();
//       log("Result data:${data.toList()}");
//       if (response.data is Map<String, dynamic>) {
// // final data = (res.data['result'] as List)
// //           .map((e) => ClassModelRoutine.fromJson(e))
// //           .toList();,

//         final studentListResponse =
//             StudentDetailListModel.fromJson(response.data);
//         log("Data:${studentListResponse.message}");
//         log("Data:${studentListResponse.count}");
//         log("Data:${studentListResponse.result?.length}");
//         log("Data:${studentListResponse.result?.first.fullName}");

//         if (studentListResponse.count != 0 &&
//             studentListResponse.result?.isNotEmpty == true) {
//           return studentListResponse;
//         } else {
//           throw Exception("Error occurs");
//         }
//       } else {
//         throw Exception("Unexpected response format");
//       }
//     } on DioException catch (error) {
//       if (error.response != null && error.response?.statusCode == 400 ||
//           error.response?.statusCode == 500) {
//         // Handle specific 400 status code
//         final message = error.response?.data['message'] ?? "Bad Request";
//         return StudentDetailListModel.withError(message);
//       }
//       // Re-throw any unhandled Dio errors
//       rethrow;
//     } catch (e) {
//       return StudentDetailListModel.withError(e.toString());
//     }
//   }
}

final studentListRepository = StudentListRepository();
