import 'dart:convert';

import 'package:test/test.dart';
import 'package:testrickmortyapp/layers/data/dto/character_dto.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  group('CharacterDto', () {
    late String referenceRawJson;
    late CharacterDto referenceDto;

    setUp(() {
      referenceDto = characterDto;

      referenceRawJson = json.encode(characterMap);
    });

    test('should create CharacterDto instance to/from JSON', () {
      final createdDto = CharacterDto.fromRawJson(referenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}
