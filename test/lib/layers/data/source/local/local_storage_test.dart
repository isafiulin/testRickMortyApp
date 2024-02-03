import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:testrickmortyapp/layers/data/source/local/local_character_storage.dart';

import '../../../../../fixtures/fixtures.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalStorageImpl localStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() async {
    mockSharedPreferences = MockSharedPreferences();
    localStorage = LocalStorageImpl(sharedPreferences: mockSharedPreferences);
  });

  group('LocalStorageImpl', () {
    test('should save a list of CharacterDto per page', () async {
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // List 1
      final result1 = await localStorage.savePage(
        page: 1,
        data: paginatedResponseResult1NextNotNull,
      );
      expect(result1, true);
      final key1 = LocalStorageImpl.getKeyToPage(1);

      final list1Raw = paginatedResponseResult1NextNotNull.toRawJson();
      verify(() => mockSharedPreferences.setString(key1, list1Raw)).called(1);

      // List 2
      final result2 = await localStorage.savePage(
        page: 2,
        data: paginatedResponseResult1NextNull,
      );
      expect(result2, true);
      final key2 = LocalStorageImpl.getKeyToPage(2);

      final list2Raw = paginatedResponseResult1NextNull.toRawJson();
      verify(() => mockSharedPreferences.setString(key2, list2Raw)).called(1);

      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should load a list of CharacterDto per page', () {
      // List 1
      final key1 = LocalStorageImpl.getKeyToPage(1);
      when(() => mockSharedPreferences.getString(key1)).thenReturn(
          json.encode(paginatedResponseResult1NextNotNull.toRawJson()));

      final result1 = localStorage.loadPage(page: 1);

      expect(result1?.result, hasLength(2));
      for (int i = 0;
          i < paginatedResponseResult1NextNotNull.result.length;
          i++) {
        expect(
            result1?.result[i], paginatedResponseResult1NextNotNull.result[i]);
      }
      verify(() => mockSharedPreferences.getString(key1)).called(1);

      // List 2
      final key2 = LocalStorageImpl.getKeyToPage(2);
      when(() => mockSharedPreferences.getString(key2)).thenReturn(
          json.encode(paginatedResponseResult1NextNull.toRawJson()));

      final result2 = localStorage.loadPage(page: 2);

      expect(result2?.result, hasLength(2));
      for (int i = 0; i < paginatedResponseResult1NextNull.result.length; i++) {
        expect(result2?.result[i], paginatedResponseResult1NextNull.result[i]);
      }
      verify(() => mockSharedPreferences.getString(key2)).called(1);

      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
