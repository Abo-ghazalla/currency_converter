import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';

abstract class ConverterRepo {
  Future<List<CurrencyModel>> fetchCurrencies();
  Future<double> convert(CurrencyConverterDto dto);
}
