import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';
import 'package:currency_converter/features/converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'currency_converter_event.dart';
part 'currency_converter_state.dart';
part 'currency_converter_bloc.freezed.dart';

@injectable
class CurrencyConverterBloc extends Bloc<CurrencyConverterEvent, CurrencyConverterState> {
  final ConvertCurrencyUseCase _convertCurrencyUseCase;

  CurrencyConverterBloc(this._convertCurrencyUseCase) : super(const _Initial()) {
    on<_Convert>(
      (event, emit) async {
        final either = await _convertCurrencyUseCase.execute(event.dto);
        either.fold(
          (amount) => emit(CurrencyConverterState.success(amount)),
          (error) => emit(CurrencyConverterState.failure(error.errorMsg)),
        );
      },
      transformer: (events, mapper) {
        return events.debounceTime(const Duration(seconds: 1)).asyncExpand(mapper);
      },
    );
  }
}
