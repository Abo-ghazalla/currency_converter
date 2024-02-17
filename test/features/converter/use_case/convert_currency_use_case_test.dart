import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';
import 'package:currency_converter/features/converter/domain/repos/converter_repo.dart';
import 'package:currency_converter/features/converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'convert_currency_use_case_test.mocks.dart';

@GenerateMocks([ConverterRepo])
void main() {
  group(
    'convert_currency_use_case_test',
    () {
      late ConverterRepo mockRepository;
      late ConvertCurrencyUseCase convertCurrencyUseCase;

      mockRepository = MockConverterRepo();
      convertCurrencyUseCase = ConvertCurrencyUseCase(mockRepository);

      CurrencyModel from = CurrencyModel.instanceForTest();
      CurrencyModel to = CurrencyModel.instanceForTest();
      final dto = CurrencyConverterDto(baseCurrency: from.code, currencies: [to.code], amount: 10);
      double resultAmount = 20;

      test(
        'when call execute then return success result',
        () async {
          when(mockRepository.convert(dto)).thenAnswer((_) async => resultAmount);

          final result = await convertCurrencyUseCase.execute(dto);
          expect(result, isA<Left<double, ErrorModel>>());
          verify(mockRepository.convert(dto)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
      test(
        'when call execute then return error',
        () async {
          when(mockRepository.convert(dto)).thenThrow(error);
          final result = await convertCurrencyUseCase.execute(dto);

          expect(result, isA<Right<double, ErrorModel>>());
          verify(mockRepository.convert(dto)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    },
  );
}

final error = ErrorModel(errorMsg: "jhk");
