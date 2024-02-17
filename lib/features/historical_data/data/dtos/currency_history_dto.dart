import 'package:currency_converter/data/model/to_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_history_dto.g.dart';

@JsonSerializable(createFactory: false)
class CurrencyHistoryDto extends ToJsonConverter {
  final List<String> currencies;
  @JsonKey(name: "base_currency")
  final String baseCurrency;
  @JsonKey(toJson: formatDateTime)
  final DateTime? date;
  const CurrencyHistoryDto({
    required this.currencies,
    this.date,
    required this.baseCurrency,
  });

  @override
  Map<String, dynamic> toJson() => _$CurrencyHistoryDtoToJson(this);

  CurrencyHistoryDto copyWithDate(DateTime date) =>
      CurrencyHistoryDto(date: date, currencies: currencies, baseCurrency: baseCurrency);
}

String formatDateTime(DateTime? date) {
  if (date == null) return "";
  return "${date.year}-${date.month}-${date.day}";
}
