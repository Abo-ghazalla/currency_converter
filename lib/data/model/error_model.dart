import 'package:dio/dio.dart';

class ErrorModel {
  final String errorMsg;
  final int? statusCode;

  ErrorModel({required this.errorMsg, this.statusCode});

  static ErrorModel catchError(error) {
    late String errorMsg;
    if (error is DioException) {
      errorMsg = error.response?.data["message"] ?? "Connection Error";
    } else if (error is String) {
      errorMsg = error;
    } else {
      errorMsg = "Something Went Wrong";
    }

    return ErrorModel(errorMsg: errorMsg);
  }
}
