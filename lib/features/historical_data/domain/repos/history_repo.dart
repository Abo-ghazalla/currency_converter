import 'package:currency_converter/features/historical_data/data/dtos/currency_history_dto.dart';

abstract class HistoryRepo {
  Future<List<Map<String, dynamic>>> fetchHistoryForLast7Days(CurrencyHistoryDto dto);
}
