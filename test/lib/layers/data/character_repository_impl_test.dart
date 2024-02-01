// ignore_for_file: avoid_redundant_argument_values

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:testrickmortyapp/layers/data/character_repository_impl.dart';
import 'package:testrickmortyapp/layers/data/source/local/local_character_storage.dart';
import 'package:testrickmortyapp/layers/data/source/network/remote_character_repository.dart';

import '../../../fixtures/fixtures.dart';

class MockApi extends Mock implements RemoteCharacterRepository {}

class MockLocalStorage extends Mock implements LocalCharacterStorage {}

void main() {
  late CharacterRepositoryImpl characterRepository;
  late MockApi mockApi;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockApi = MockApi();
    mockLocalStorage = MockLocalStorage();
    characterRepository = CharacterRepositoryImpl(
      remoteCharacterRepository: mockApi,
      localCharacterStorage: mockLocalStorage,
    );
  });

  group('CharacterRepositoryImpl', () {
    test('getCharacters should return cached characters if available',
        () async {
      const page = 0;
      final cachedCharacters = characterList1;
      when(() => mockLocalStorage.loadPage(page: page))
          .thenReturn(cachedCharacters);

      final result = await characterRepository.getCharacters(page: page);

      expect(result, equals(cachedCharacters));

      verify(() => mockLocalStorage.loadPage(page: page)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
      verifyZeroInteractions(mockApi);
    });

    test(
        'getCharacters should fetch characters from API and save to local storage',
        () async {
      const page = 1;
      final apiCharacters = characterList2;
      when(() => mockLocalStorage.loadPage(page: page)).thenReturn([]);
      when(() => mockApi.loadCharacters(page: page))
          .thenAnswer((_) async => apiCharacters);
      when(
        () => mockLocalStorage.savePage(
          page: page,
          list: apiCharacters,
        ),
      ).thenAnswer((_) async => true);

      final result = await characterRepository.getCharacters(page: page);

      expect(result, equals(apiCharacters));
      verify(() => mockLocalStorage.loadPage(page: page)).called(1);
      verify(() => mockApi.loadCharacters(page: page)).called(1);
      verify(
        () => mockLocalStorage.savePage(
          page: page,
          list: apiCharacters,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
      verifyNoMoreInteractions(mockApi);
    });
  });
}
