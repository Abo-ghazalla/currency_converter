part of 'history_cubit.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.loading() = _Loading;
  const factory HistoryState.success(List<Map<String, dynamic>> results) = _Success;
  const factory HistoryState.failure(String msg) = _Failure;
}
