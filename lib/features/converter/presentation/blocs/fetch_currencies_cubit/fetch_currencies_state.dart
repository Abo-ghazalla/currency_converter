part of 'fetch_currencies_cubit.dart';

@freezed
class FetchCurrenciesState with _$FetchCurrenciesState {
  const factory FetchCurrenciesState.loading() = _Loading;
  const factory FetchCurrenciesState.success(List<CurrencyModel> currencies) = _Success;
  const factory FetchCurrenciesState.failure(String errorMsg) = _Failure;
}
