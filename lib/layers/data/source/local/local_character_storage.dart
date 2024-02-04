import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/domain/repository/local_repository.dart';

const cachedCharacterListKey = 'CACHED_CHARACTER_LIST_PAGE';

abstract class LocalCharacterStorage implements LocalStorage {}

@LazySingleton(as: LocalCharacterStorage)
class LocalStorageImpl implements LocalCharacterStorage {
  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;
  final SharedPreferences _sharedPref;

  @override
  PaginatedResponseResult? loadPage({required int page}) {
    final key = getKeyToPage(page);
    final jsonString = _sharedPref.getString(key);

    return jsonString != null
        ? PaginatedResponseResult.fromJsonString(jsonString)
        : null;
  }

  @override
  Future<bool> savePage({
    PaginatedResponseResult? data,
    required int page,
  }) {
    final key = getKeyToPage(page);

    if (data != null) {
      final jsonString = data.toRawJson();
      return _sharedPref.setString(key, jsonString);
    }
    return _sharedPref.setString(key, '');
  }

  @visibleForTesting
  static String getKeyToPage(int page) {
    return '${cachedCharacterListKey}_$page';
  }
}
