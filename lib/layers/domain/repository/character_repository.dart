import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';

abstract class CharacterRepository {
  Future<PaginatedResponseResult?> getCharacters(
      {int page = 0, CharacterFilters? filter});
  Future<List<Character>?> getCharactersByIds({required List<int> listIds});
}
