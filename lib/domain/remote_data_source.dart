import 'package:currency_converter/data/model/to_json_converter.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<Map<String, dynamic>> getRequest({
    required String path,
    ToJsonConverter? query,
  });

  Right<Map<String, dynamic>, String> catchApiRequestError(error);
}
