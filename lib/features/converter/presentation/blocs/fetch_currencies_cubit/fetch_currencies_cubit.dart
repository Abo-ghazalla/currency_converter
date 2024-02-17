import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/features/converter/domain/use_cases/fetch_currencies_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'fetch_currencies_state.dart';
part 'fetch_currencies_cubit.freezed.dart';

@injectable
class FetchCurrenciesCubit extends Cubit<FetchCurrenciesState> {
  final FetchCurrenciesUseCase _fetchCurrenciesUseCase;
  FetchCurrenciesCubit(this._fetchCurrenciesUseCase) : super(const FetchCurrenciesState.loading());

  Future<void> fetchCurrencies() async {
    emit(const FetchCurrenciesState.loading());
    final either = await _fetchCurrenciesUseCase.execute();
    either.fold(
      (currencies) => emit(FetchCurrenciesState.success(currencies)),
      (error) => emit(FetchCurrenciesState.failure(error.errorMsg)),
    );
  }
}
