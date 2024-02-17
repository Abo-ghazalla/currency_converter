import 'package:currency_converter/data/model/currency_model.dart';

abstract class LocalDataSource {
  Future<void> writeCurrencies(List<CurrencyModel> currencies);
  Future<List<CurrencyModel>> readCurrencies();
}
