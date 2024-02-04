import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/repository/character_repository.dart';

@LazySingleton()
class GetCharactersByIDs {
  GetCharactersByIDs({
    required CharacterRepository repository,
  }) : _repository = repository;

  final CharacterRepository _repository;

  Future<List<Character>?> call({required List<int> listIds}) async {
    final result = await _repository.getCharactersByIds(listIds: listIds);
    return result;
  }
}
