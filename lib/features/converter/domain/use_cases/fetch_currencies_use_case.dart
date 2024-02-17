import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/converter/domain/repos/converter_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCurrenciesUseCase {
  final ConverterRepo _converterRepo;

  FetchCurrenciesUseCase(this._converterRepo);

  Future<Either<List<CurrencyModel>, ErrorModel>> execute() async {
    try {
      final result = await _converterRepo.fetchCurrencies();
      return Left(result);
    } catch (e) {
      return Right(ErrorModel.catchError(e));
    }
  }
}
