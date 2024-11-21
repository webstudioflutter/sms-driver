import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseController {
  static const String _baseUrl = 'http://62.72.42.129:8080';
  static const String _appUrl = '$_baseUrl/api/v1/en';

  String get appUrl => _appUrl;

  late final Dio _dio;

  // Constructor to initialize Dio with interceptors
  BaseController() {
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: const Duration(milliseconds: 10000),
      connectTimeout: const Duration(milliseconds: 10000),
    );

    _dio = Dio(options);

    // Add interceptors for request handling and logging
    _dio.interceptors.addAll([
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';

          // Include token if available
          final token = await getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options); // Continue with the request
        },
      ),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  // Method to retrieve the authentication token from shared preferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Error handling method
  String handleError(dynamic error) {
    String errorDescription = 'Unexpected error occurred';

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'No internet connection';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioExceptionType.badResponse:
          errorDescription = _handleBadResponse(error.response);
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Send timeout in connection with API server';
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
          errorDescription = 'No internet connection';
          break;
      }
    }
    return errorDescription;
  }

  // Handle specific status codes from the response
  String _handleBadResponse(Response? response) {
    if (response == null || response.data == null) {
      return 'Unexpected error occurred';
    }

    final statusCode = response.statusCode;
    final message = response.data['message'] ?? 'An error occurred';

    switch (statusCode) {
      case 400:
        return message;
      case 401:
        return 'Unauthenticated';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Page not found';
      case 422:
        return _parseValidationErrors(response.data['errors']);
      case 500:
        return 'Internal server error';
      default:
        return message;
    }
  }

  // Parse validation errors from the response
  String _parseValidationErrors(Map<String, dynamic>? errors) {
    if (errors == null) return 'Validation error occurred';
    return errors.entries
        .map((entry) => '${entry.key}: ${(entry.value as List).join(", ")}')
        .join('; ');
  }

  // Getter for Dio instance
  Dio get dio => _dio;
}

// Register BaseController as a singleton instance
final baseController = BaseController();
