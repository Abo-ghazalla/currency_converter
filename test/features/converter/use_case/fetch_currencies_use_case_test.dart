import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/converter/domain/repos/converter_repo.dart';
import 'package:currency_converter/features/converter/domain/use_cases/fetch_currencies_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_currencies_use_case_test.mocks.dart';

@GenerateMocks([ConverterRepo])
void main() {
  group(
    'fetch_currencies_use_case_test',
    () {
      late ConverterRepo mockRepository;
      late FetchCurrenciesUseCase fetchCurrenciesUseCase;

      mockRepository = MockConverterRepo();
      fetchCurrenciesUseCase = FetchCurrenciesUseCase(mockRepository);

      List<CurrencyModel> currencies = [CurrencyModel(code: "code", name: "name", namePlural: "df", symbol: "ss")];

      test(
        'when call execute then return success result',
        () async {
          when(mockRepository.fetchCurrencies()).thenAnswer((_) async => currencies);

          final result = await fetchCurrenciesUseCase.execute();
          expect(result, isA<Left<List<CurrencyModel>, ErrorModel>>());
          verify(mockRepository.fetchCurrencies()).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
      test(
        'when call execute then return error',
        () async {
          when(mockRepository.fetchCurrencies()).thenThrow(error);
          final result = await fetchCurrenciesUseCase.execute();

          expect(result, isA<Right<List<CurrencyModel>, ErrorModel>>());
          verify(mockRepository.fetchCurrencies()).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    },
  );
}

final error = ErrorModel(errorMsg: "jhk");
