import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/historical_data/data/dtos/currency_history_dto.dart';
import 'package:currency_converter/features/historical_data/domain/use_cases/usd_jpy_history_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final UsdJpyHistoryUseCase _usdJpyHistoryUseCase;
  HistoryCubit(this._usdJpyHistoryUseCase) : super(const HistoryState.loading());

  Future<void> fetchHistory({
    CurrencyHistoryDto dto = const CurrencyHistoryDto(baseCurrency: "USD", currencies: ["JPY"]),
  }) async {
    final either = await _usdJpyHistoryUseCase.execute(dto);
    either.fold(
      (results) => emit(HistoryState.success(results)),
      (error) => emit(HistoryState.failure(error.errorMsg)),
    );
  }
}
