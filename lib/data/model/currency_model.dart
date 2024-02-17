import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel {
  final String code;
  final String name;
  @JsonKey(name: "name_plural")
  final String namePlural;
  final String symbol;
  @JsonKey(includeFromJson: false, includeToJson: true)
  late final String flagUrl;
  CurrencyModel({
    required this.code,
    required this.name,
    required this.namePlural,
    required this.symbol,
  }) {
    flagUrl = "https://flagcdn.com/w40/${code.toLowerCase().substring(0, code.length - 1)}.png";
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => _$CurrencyModelFromJson(json);
  factory CurrencyModel.instanceForTest() => CurrencyModel(code: "code", name: "name", namePlural: "namePlural", symbol: "symbol");
  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
