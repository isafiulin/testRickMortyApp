import 'package:testrickmortyapp/layers/core/models/response_result.dart';

abstract class CharacterRepository {
  Future<PaginatedResponseResult?> getCharacters({int page = 0});
}
