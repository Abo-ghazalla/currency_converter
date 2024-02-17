import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/historical_data/data/dtos/currency_history_dto.dart';
import 'package:currency_converter/features/historical_data/domain/use_cases/usd_jpy_history_use_case.dart';
import 'package:currency_converter/features/historical_data/presentation/history_cubit/history_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'history_cubit_test.mocks.dart';

@GenerateMocks([UsdJpyHistoryUseCase])
void main() {
  final results = <Map<String, dynamic>>[];
  const dto = CurrencyHistoryDto(currencies: [""], baseCurrency: "");
  late UsdJpyHistoryUseCase mockUsdJpyHistoryUseCase;
  setUpAll(() {
    mockUsdJpyHistoryUseCase = MockUsdJpyHistoryUseCase();
  });

  group("HistoryCubit", () {
    blocTest<HistoryCubit, HistoryState>(
      'emits  success when fetching history process succeeded',
      build: () => HistoryCubit(mockUsdJpyHistoryUseCase),
      wait: const Duration(seconds: 1),
      act: (cubit) async {
        when(mockUsdJpyHistoryUseCase.execute(dto)).thenAnswer((_) => Future.value(Left(results)));
        cubit.fetchHistory(dto: dto);
      },
      expect: () => <HistoryState>[
        HistoryState.success(results),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'emits  Error when Error Happens',
      build: () => HistoryCubit(mockUsdJpyHistoryUseCase),
      wait: const Duration(seconds: 1),
      act: (bloc) async {
        when(mockUsdJpyHistoryUseCase.execute(dto)).thenAnswer((_) => Future.value(Right(_error)));
        bloc.fetchHistory(dto: dto);
      },
      expect: () => <HistoryState>[
        HistoryState.failure(_error.errorMsg),
      ],
    );
  });
}

final _error = ErrorModel(errorMsg: "errorMsg");
