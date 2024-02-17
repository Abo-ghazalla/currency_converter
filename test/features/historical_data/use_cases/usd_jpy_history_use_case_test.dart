import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/historical_data/data/dtos/currency_history_dto.dart';
import 'package:currency_converter/features/historical_data/domain/repos/history_repo.dart';
import 'package:currency_converter/features/historical_data/domain/use_cases/usd_jpy_history_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'usd_jpy_history_use_case_test.mocks.dart';

@GenerateMocks([HistoryRepo])
void main() {
  group(
    'usd_jpy_history_use_case_test',
    () {
      late HistoryRepo mockRepository;
      late UsdJpyHistoryUseCase usdJpyHistoryUseCase;
      final dto = CurrencyHistoryDto(baseCurrency: "", currencies: []);
      mockRepository = MockHistoryRepo();
      usdJpyHistoryUseCase = UsdJpyHistoryUseCase(mockRepository);

      final results = <Map<String, dynamic>>[];
      test(
        'when call execute then return success result',
        () async {
          when(mockRepository.fetchHistoryForLast7Days(dto)).thenAnswer((_) async => results);

          final result = await usdJpyHistoryUseCase.execute(dto);
          expect(result, isA<Left<List <Map<String, dynamic>>, ErrorModel>>());
          verify(mockRepository.fetchHistoryForLast7Days(dto)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
      test(
        'when call execute then return error',
        () async {
          when(mockRepository.fetchHistoryForLast7Days(dto)).thenThrow(error);
          final result = await usdJpyHistoryUseCase.execute(dto);

          expect(result, isA<Right<List <Map<String, dynamic>>, ErrorModel>>());
          verify(mockRepository.fetchHistoryForLast7Days(dto)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    },
  );
}

final error = ErrorModel(errorMsg: "jhk");
