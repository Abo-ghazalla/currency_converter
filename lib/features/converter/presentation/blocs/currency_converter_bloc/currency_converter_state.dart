part of 'currency_converter_bloc.dart';

@freezed
class CurrencyConverterState with _$CurrencyConverterState {
  const factory CurrencyConverterState.initial() = _Initial;
  const factory CurrencyConverterState.success(double amount) = _Success;
  const factory CurrencyConverterState.failure(String error) = _Failure;
}
