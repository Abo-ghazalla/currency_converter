import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/converter/domain/use_cases/fetch_currencies_use_case.dart';
import 'package:currency_converter/features/converter/presentation/blocs/fetch_currencies_cubit/fetch_currencies_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_currencies_cubit_test.mocks.dart';

@GenerateMocks([FetchCurrenciesUseCase])
void main() {
  late FetchCurrenciesUseCase mockFetchCurrenciesUseCase;
  final currencies = <CurrencyModel>[];
  setUpAll(() {
    mockFetchCurrenciesUseCase = MockFetchCurrenciesUseCase();
  });

  group("fetchCurrenciesCubit", () {
    blocTest<FetchCurrenciesCubit, FetchCurrenciesState>(
      'emits loading then success when fetch currencies process succeeded',
      build: () => FetchCurrenciesCubit(mockFetchCurrenciesUseCase),
      act: (cubit) {
        when(mockFetchCurrenciesUseCase.execute()).thenAnswer((_) => Future.value(Left(currencies)));
        cubit.fetchCurrencies();
      },
      expect: () => <FetchCurrenciesState>[
        const FetchCurrenciesState.loading(),
        FetchCurrenciesState.success(currencies),
      ],
    );

    blocTest<FetchCurrenciesCubit, FetchCurrenciesState>(
      'emits loading then error when exception happens',
      build: () => FetchCurrenciesCubit(mockFetchCurrenciesUseCase),
      act: (cubit) {
        when(mockFetchCurrenciesUseCase.execute()).thenAnswer((_) => Future.value(Right(_error)));
        cubit.fetchCurrencies();
      },
      expect: () => <FetchCurrenciesState>[
        const FetchCurrenciesState.loading(),
        FetchCurrenciesState.failure(_error.errorMsg),
      ],
    );
  });
}

final _error = ErrorModel(errorMsg: "errorMsg");
