import 'package:currency_converter/data/model/error_model.dart';
import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';
import 'package:currency_converter/features/converter/domain/repos/converter_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConvertCurrencyUseCase {
  final ConverterRepo _converterRepo;

  ConvertCurrencyUseCase(this._converterRepo);

  Future<Either<double, ErrorModel>> execute(CurrencyConverterDto dto) async {
    try {
      final result = await _converterRepo.convert(dto);
      return Left(result * dto.amount);
    } catch (e) {
      return Right(ErrorModel.catchError(e));
    }
  }
}
