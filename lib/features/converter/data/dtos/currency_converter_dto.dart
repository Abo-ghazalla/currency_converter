import 'package:currency_converter/data/model/to_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_converter_dto.g.dart';

@JsonSerializable(createFactory: false)
class CurrencyConverterDto extends ToJsonConverter {
  final List<String> currencies;
  @JsonKey(name: "base_currency")
  final String baseCurrency;
  @JsonKey(includeToJson: false)
  final double amount;
  CurrencyConverterDto({
    required this.currencies,
    required this.baseCurrency,
    required this.amount,
  });

  @override
  Map<String, dynamic> toJson() => _$CurrencyConverterDtoToJson(this);
}
