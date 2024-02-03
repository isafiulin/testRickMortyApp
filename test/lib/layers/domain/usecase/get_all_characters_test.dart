// ignore_for_file: avoid_redundant_argument_values

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/repository/character_repository.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late GetAllCharacters getAllCharacters;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    getAllCharacters = GetAllCharacters(repository: mockCharacterRepository);
  });

  group('GetAllCharacters', () {
    test('call should return a list of characters', () async {
      const page = 0;
      final characters = [
        Character(id: 1, name: 'Rick Sanchez'),
        Character(id: 2, name: 'Morty Smith'),
      ];
      final paginatedResponse = PaginatedResponseResult(
          count: characters.length, next: 'nextPage', result: characters);

      when(() => mockCharacterRepository.getCharacters(page: page))
          .thenAnswer((_) async => paginatedResponse);

      final result = await getAllCharacters.call(page: page);

      expect(result, equals(paginatedResponse));

      verify(() => mockCharacterRepository.getCharacters(page: page)).called(1);
      verifyNoMoreInteractions(mockCharacterRepository);
    });
  });
}
