import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/domain/local_data_source.dart';
import 'package:currency_converter/domain/remote_data_source.dart';
import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';
import 'package:currency_converter/features/converter/domain/repos/converter_repo.dart';
import 'package:currency_converter/utils/constants/api_const.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ConverterRepo)
class ConverterRepoImpl implements ConverterRepo {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  ConverterRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<CurrencyModel>> fetchCurrencies() async {
    late List<CurrencyModel> currencies;
    currencies = await _localDataSource.readCurrencies();
    if (currencies.isNotEmpty) {
      return currencies;
    } else {
      final response = await _remoteDataSource.getRequest(path: ApiConst.currencies);

      currencies = (response["data"] as Map<String, dynamic>)
          .values
          .map((e) => CurrencyModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _localDataSource.writeCurrencies(currencies);
      return currencies;
    }
  }

  @override
  Future<double> convert(CurrencyConverterDto dto) async {
    final response = await _remoteDataSource.getRequest(path: ApiConst.latest, query: dto);

    return (response["data"] as Map<String, dynamic>).values.first;
  }
}
