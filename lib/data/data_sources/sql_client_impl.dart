import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/domain/local_data_source.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:injectable/injectable.dart';

@Singleton(as: LocalDataSource)
class SqlClientImpl implements LocalDataSource {
  @override
  Future<List<CurrencyModel>> readCurrencies() async {
    final db = await _databaseInstance;
    final data = await db.query(_tableName);
    return data.map((e) => CurrencyModel.fromJson(e)).toList();
  }

  @override
  Future<void> writeCurrencies(List<CurrencyModel> currencies) async {
    final db = await _databaseInstance;
    final batch = db.batch();
    for (final item in currencies) {
      batch.insert(_tableName, item.toJson());
    }
    await batch.commit(noResult: true);
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_db.db');

    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE $_tableName ("
        "code TEXT PRIMARY KEY, "
        "name TEXT, "
        "name_plural TEXT, "
        "symbol TEXT, "
        "flagUrl TEXT)",
      );
    });
  }

  Database? _database;
  static const _tableName = 'Currencies';

  Future<Database> get _databaseInstance async {
    _database ??= await _initDatabase();
    return _database!;
  }
}
