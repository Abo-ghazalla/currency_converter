import 'package:currency_converter/utils/constants/api_const.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => ApiConst.baseUrl;

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(
        BaseOptions(
          baseUrl: url,
          headers: {
            "Content-Type": 'application/json',
            'Accept': 'application/json',
          },
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );
}
