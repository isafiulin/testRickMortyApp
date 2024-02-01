import 'package:injectable/injectable.dart';
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
  Future<List<Character>> getCharacters({int page = 0}) async {
    final cachedList = _localCharacterStorage.loadPage(page: page);
    if (cachedList.isNotEmpty) {
      return cachedList as List<Character>;
    }

    final fetchedList =
        await _remoteCharacterRepository.loadCharacters(page: page);
    await _localCharacterStorage.savePage(page: page, list: fetchedList);
    return fetchedList;
  }
}
