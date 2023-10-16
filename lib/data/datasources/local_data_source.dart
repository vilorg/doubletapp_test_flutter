import 'package:doubletapp_habits/core/error/exception.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDataSource {
  /// Gets the cached [HabbitModel] which was gotten the last time
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<HabbitModel>> getLocalHabbits();

  /// Save to cache [HabbitModel] to local data source
  ///
  /// Throws [CacheException] if data has error.
  Future<void> saveHabbitsToCache(List<HabbitModel> habbits);

  /// Save to cache one item of [HabbitModel] to local data source
  ///
  /// Throws [CacheException] if data has error.
  Future<void> saveHabbitToCache(HabbitModel habbit);

  /// Delete all [HabbitModel] from local data source
  ///
  /// Throws [CacheException] if data has error.
  Future<void> deleteHabbitsFromCache();

  /// Delete item [HabbitModel] from local data source
  ///
  /// Throws [CacheException] if data has error.
  Future<void> deleteHabbitFromCache(int index);

  /// Campact all [HabbitModel] data from local data source
  ///
  /// Throws [CacheException] if data has error.
  Future<void> compactHabbitsFromCache();
}

const cachedHabbits = 'CACHED_HABBITS';
const jwtToken = "JWT_TOKEN";
const isLogged = 'IS_LOGGED';

class LocalDataSourceImpl implements LocalDataSource {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  LocalDataSourceImpl();

  @override
  Future<List<HabbitModel>> getLocalHabbits() async {
    return Hive.box<HabbitModel>(habbitsBoxName).values.toList();
  }

  @override
  Future<void> saveHabbitsToCache(List<HabbitModel> habbits) async {
    try {
      Hive.box<HabbitModel>(habbitsBoxName).addAll(habbits);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveHabbitToCache(HabbitModel habbit) async {
    try {
      Hive.box<HabbitModel>(habbitsBoxName).add(habbit);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteHabbitsFromCache() async {
    try {
      Hive.box<HabbitModel>(habbitsBoxName).deleteFromDisk();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteHabbitFromCache(int index) async {
    try {
      Hive.box<HabbitModel>(habbitsBoxName).deleteAt(index);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> compactHabbitsFromCache() async {
    try {
      Hive.box<HabbitModel>(habbitsBoxName).compact();
      Hive.box<HabbitModel>(habbitsBoxName).close();
    } catch (e) {
      throw CacheException();
    }
  }
}
