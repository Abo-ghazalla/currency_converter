part of 'currency_converter_bloc.dart';

@freezed
class CurrencyConverterEvent with _$CurrencyConverterEvent {
  const factory CurrencyConverterEvent.convert(CurrencyConverterDto dto) = _Convert;
}
