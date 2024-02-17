import 'package:currency_converter/data/data_sources/dio_request_interceptor.dart';
import 'package:currency_converter/di/dependency_init.dart';
import 'package:currency_converter/data/model/to_json_converter.dart';
import 'package:currency_converter/domain/remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RemoteDataSource)
class DioClientImpl implements RemoteDataSource {
  final Dio _dio;

  DioClientImpl(this._dio) {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }

    _dio.interceptors.add(getIt<DioRequestInterceptor>());
  }

  @override
  Future<Map<String, dynamic>> getRequest({
    required String path,
    ToJsonConverter? query,
  }) async {
    final res = await _dio.get(
      path,
      queryParameters: query?.toJson(),
    );

    return res.data;
  }

  @override
  Right<Map<String, dynamic>, String> catchApiRequestError(error) {
    late String errorMsg;
    if (error is DioException) {
      errorMsg = error.response?.data["message"] ?? "Connection Error";
    } else if (error is String) {
      errorMsg = error;
    } else {
      errorMsg = "Something Went Wrong";
    }

    return Right(errorMsg);
  }
}
