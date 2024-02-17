import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/historical_data/data/dtos/currency_history_dto.dart';
import 'package:currency_converter/features/historical_data/domain/repos/history_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsdJpyHistoryUseCase {
  final HistoryRepo _historyRepo;

  UsdJpyHistoryUseCase(this._historyRepo);

  Future<Either<List<Map<String, dynamic>>, ErrorModel>> execute(CurrencyHistoryDto dto) async {
    try {
    final result = await _historyRepo.fetchHistoryForLast7Days(dto);

    return Left(result);
    } catch (e) {
      return Right(ErrorModel.catchError(e));
    }
  }
}
