import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/domain/repository/character_repository.dart';

@LazySingleton()
class GetAllCharacters {
  GetAllCharacters({
    required CharacterRepository repository,
  }) : _repository = repository;

  final CharacterRepository _repository;

  Future<PaginatedResponseResult?> call({int page = 0}) async {
    final result = await _repository.getCharacters(page: page);
    return result;
  }
}
