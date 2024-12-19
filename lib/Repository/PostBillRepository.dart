import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Model/postBillModel.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostBillRepository {
  late final Dio _dio;
  late final String appUrl;

  PostBillRepository() {
    _dio = baseController.dio;
    appUrl = baseController.appUrl;
  }

  Future<PostBillModel> postBillData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      // Sending a POST request to submit vehicle expenses data
      final response = await http.post(
        Uri.parse(
          '$appUrl/vehicle-expenses',
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        log("Success: ${response.body}");
        return PostBillModel.fromJson(json.decode(response.body));
      } else {
        log("Error response: ${response.statusCode} - ${response.body}");
        return PostBillModel.withError("Error: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      log('DioError: ${dioError.message}\nStacktrace: ${dioError.stackTrace}',
          name: 'PostBillRepository');
      return PostBillModel.withError(baseController.handleError(dioError));
    } catch (error, stacktrace) {
      // Catch any other type of exception
      log('Error: $error\nStacktrace: $stacktrace', name: 'PostBillRepository');
      return PostBillModel.withError(baseController.handleError(error));
    }
  }
}

final postBillRepository = PostBillRepository();





// import 'package:dio/dio.dart';
// import 'package:driver_app/Repository/auth/Basecontroller.dart';

// class PostBillRepository {
//   late final String _appUrl;
//   late final Dio _dio;

//   PostBillRepository() {
//     _dio = baseController.dio;
//     _appUrl = baseController.appUrl;
//   }

//   Future<Map<String, dynamic>> postBillData(Map<String, dynamic> data) async {
//     try {
//       final response = await _dio.post(
//         '$_appUrl/vehicle-expenses',
//         data: data,
//       );

//       if (response.data['message'] == "Success") {
//         // Extract the result from the response
//         final result = response.data['result'] as Map<String, dynamic>;
//         log("Data successfully submitted: $result");
//         return {
//           'status': true,
//           'message': "Data successfully submitted",
//           'data': result,
//         };
//       } else {
//         throw Exception("Failed to submit data");
//       }
//     } on DioException catch (error) {
//       log('DioException: ${error.message}');
//       return {
//         'status': false,
//         'message': "Failed to connect to the server: ${error.message}",
//       };
//     } catch (e) {
//       log('Error: $e');
//       return {
//         'status': false,
//         'message': "An unexpected error occurred: $e",
//       };
//     }
//   }
// }

// final postBillRepository = PostBillRepository();

