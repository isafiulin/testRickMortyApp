import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testrickmortyapp/layers/data/dto/character_dto.dart';
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
  List<CharacterDto> loadPage({required int page}) {
    final key = getKeyToPage(page);
    final jsonList = _sharedPref.getStringList(key);

    return jsonList != null
        ? jsonList.map((e) => CharacterDto.fromRawJson(e)).toList()
        : [];
  }

  @override
  Future<bool> savePage({
    required int page,
    required List<dynamic> list,
  }) {
    final key = getKeyToPage(page);

    if (list is List<CharacterDto>) {
      final jsonList = list.map((e) => e.toRawJson()).toList();
      return _sharedPref.setStringList(key, jsonList);
    }
    return _sharedPref.setStringList(key, []);
  }

  @visibleForTesting
  static String getKeyToPage(int page) {
    return '${cachedCharacterListKey}_$page';
  }
}
