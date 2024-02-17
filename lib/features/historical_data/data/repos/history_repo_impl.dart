import 'package:currency_converter/domain/remote_data_source.dart';
import 'package:currency_converter/features/historical_data/data/dtos/currency_history_dto.dart';
import 'package:currency_converter/features/historical_data/domain/repos/history_repo.dart';
import 'package:currency_converter/utils/constants/api_const.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HistoryRepo)
class HistoryRepoImpl implements HistoryRepo {
  final RemoteDataSource _remoteDataSource;

  HistoryRepoImpl(this._remoteDataSource);
  @override
  Future<List<Map<String, dynamic>>> fetchHistoryForLast7Days(CurrencyHistoryDto dto) async {
    List<Map<String, dynamic>> results = [];
    final todayDate = DateTime.now();

    final responses = await Future.wait(List.generate(
      7,
      (index) => _remoteDataSource.getRequest(
        path: ApiConst.historical,
        query: dto.copyWithDate(todayDate.subtract(Duration(days: index + 1))),
      ),
    ));
    for (final item in responses) {
      results.add(item["data"]);
    }
    return results;
  }
}
