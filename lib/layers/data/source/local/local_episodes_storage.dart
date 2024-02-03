import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/data/dto/episodes_dto.dart';
import 'package:testrickmortyapp/layers/domain/repository/local_repository.dart';

const cachedEpisodeListKey = 'CACHED_EPISODE_LIST_PAGE';

abstract class LocalEpisodeStorage implements LocalStorage {}

@LazySingleton(as: LocalEpisodeStorage)
class LocalEpisodesStorageImpl implements LocalEpisodeStorage {
  LocalEpisodesStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;
  final SharedPreferences _sharedPref;

  @override
  PaginatedResponseResult? loadPage({required int page}) {
    final key = getKeyToPage(page);
    final jsonString = _sharedPref.getString(key);

    return jsonString != null
        ? PaginatedResponseResult.fromJsonString(
            json.decode(jsonString) as String)
        : null;
  }

  @override
  Future<bool> savePage({
    PaginatedResponseResult? data,
    required int page,
  }) {
    final key = getKeyToPage(page);

    if (data != null) {
      if (data.result is List<EpisodeDto>) {
        final jsonString = data.toRawJson();
        return _sharedPref.setString(key, jsonString);
      }
    }
    return _sharedPref.setString(key, '');
  }

  @visibleForTesting
  static String getKeyToPage(int page) {
    return '${cachedEpisodeListKey}_$page';
  }
}
