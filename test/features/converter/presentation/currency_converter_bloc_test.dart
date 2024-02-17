import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';
import 'package:currency_converter/features/converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/converter/presentation/blocs/currency_converter_bloc/currency_converter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_converter_bloc_test.mocks.dart';

@GenerateMocks([ConvertCurrencyUseCase])
void main() {
  double resultAmount = 21;
  final dto = CurrencyConverterDto(amount: 12, currencies: [""], baseCurrency: "");
  late ConvertCurrencyUseCase mockConvertCurrencyUseCase;
  setUpAll(() {
    mockConvertCurrencyUseCase = MockConvertCurrencyUseCase();
  });

  group("CurrencyConverterBloc", () {
    blocTest<CurrencyConverterBloc, CurrencyConverterState>(
      'emits  success when converting currencies process succeeded',
      build: () => CurrencyConverterBloc(mockConvertCurrencyUseCase),
      wait: const Duration(seconds: 1),
      act: (bloc) async {
        when(mockConvertCurrencyUseCase.execute(dto)).thenAnswer((_) => Future.value(Left(resultAmount)));
        bloc.add(CurrencyConverterEvent.convert(dto));
      },
      expect: () => <CurrencyConverterState>[
        CurrencyConverterState.success(resultAmount),
      ],
    );

    blocTest<CurrencyConverterBloc, CurrencyConverterState>(
      'emits  Error when Error Happens',
      build: () => CurrencyConverterBloc(mockConvertCurrencyUseCase),
      wait: const Duration(seconds: 1),
      act: (bloc) async {
        when(mockConvertCurrencyUseCase.execute(dto)).thenAnswer((_) => Future.value(Right(_error)));
        bloc.add(CurrencyConverterEvent.convert(dto));
      },
      expect: () => <CurrencyConverterState>[
        CurrencyConverterState.failure(_error.errorMsg),
      ],
    );
  });
}

final _error = ErrorModel(errorMsg: "errorMsg");
