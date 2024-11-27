// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:driver_app/Model/postBillModel.dart';
// import 'package:driver_app/Repository/auth/Basecontroller.dart';

// class PostBillRepository {
//   late final Dio _dio;
//   late final String appUrl;

//   PostBillRepository() {
//     _dio = baseController.dio;
//     appUrl = baseController.appUrl;
//   }

//   Future<PostBillModel> postBillData(Map<String, dynamic> data) async {
//     try {
//       // Sending a GET request to fetch vehicle expenses
//       Response response = await _dio.post(
//         '$appUrl/vehicle-expenses',
//         data: data,
//       );

//       // Check if the response is not empty and parse the data into a BillModel
//       if (response.data != null) {
//         log(" Success ${response.data}");
//         return PostBillModel.fromJson(response.data);
//       } else {
//         log("Successmessage${response.statusMessage}");
//         return PostBillModel.withError("${response.statusMessage}");
//       }
//     } catch (error, stacktrace) {
//       // Enhanced error logging
//       log('Error occurred while fetching Bill data: $error\nStacktrace: $stacktrace',
//           name: 'PostBillRepository');
//       return PostBillModel.withError(baseController.handleError(error));
//     }
//   }
// }

// final postBillRepository = PostBillRepository();

// import 'dart:developer';

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

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';

class PostBillRepository {
  late final String _appUrl;
  late final Dio _dio;

  PostBillRepository() {
    _dio = baseController.dio;
    _appUrl = baseController.appUrl;
  }

  Future<Map<String, dynamic>> postBillData(
      Map<String, dynamic> billdata) async {
    try {
      final response = await _dio.post(
        '$_appUrl/vehicle-expenses',
        data: billdata,
      );

      if (response.data['message'] == "Success") {
        // Extract the result from the response
        final result = response.data['result'] as Map<String, dynamic>;
        log("Data successfully submitted: $result");
        return {
          'status': true,
          'message': "Data successfully submitted",
          'data': result,
        };
      } else {
        throw Exception("Failed to submit data");
      }
    } on DioException catch (error) {
      log('DioException: ${error.message}');
      return {
        'status': false,
        'message': "Failed to connect to the server: ${error.message}",
      };
    } catch (e) {
      log('Error: $e');
      return {
        'status': false,
        'message': "An unexpected error occurred: $e",
      };
    }
  }
}

final postBillReppository = PostBillRepository();
