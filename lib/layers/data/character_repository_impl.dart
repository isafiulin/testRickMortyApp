import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/data/source/local/local_character_storage.dart';
import 'package:testrickmortyapp/layers/data/source/network/remote_character_repository.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/repository/character_repository.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({
    required RemoteCharacterRepository remoteCharacterRepository,
    required LocalCharacterStorage localCharacterStorage,
  })  : _remoteCharacterRepository = remoteCharacterRepository,
        _localCharacterStorage = localCharacterStorage;
  final RemoteCharacterRepository _remoteCharacterRepository;
  final LocalCharacterStorage _localCharacterStorage;

  @override
  Future<PaginatedResponseResult?> getCharacters(
      {int page = 0, CharacterFilters? filter}) async {
    //TODO чтобы не работать с локал стораджем и фильтром, нету времени доделать
    if (filter == null) {
      final cachedList = _localCharacterStorage.loadPage(page: page);
      if (cachedList != null) {
        return cachedList;
      }
    }
    final fetchedList = await _remoteCharacterRepository.loadCharacters(
        page: page, filter: filter);
    if (filter == null) {
      await _localCharacterStorage.savePage(page: page, data: fetchedList);
    }
    return fetchedList;
  }

  @override
  Future<List<Character>?> getCharactersByIds(
      {required List<int> listIds}) async {
    final fetchedList =
        await _remoteCharacterRepository.loadCharactersByIds(listIds: listIds);

    return fetchedList;
  }
}
