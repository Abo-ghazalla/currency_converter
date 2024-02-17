import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioRequestInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters = {
      ...options.queryParameters,
      "apikey": "fca_live_W5nlbIwnPMhtKFWk6kq7vpcw3jJESg1IEacasfhS",
    };
    super.onRequest(options, handler);
  }
}
