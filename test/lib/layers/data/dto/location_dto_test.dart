import 'dart:convert';

import 'package:test/test.dart';
import 'package:testrickmortyapp/layers/data/dto/location_dto.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  group('LocationDto', () {
    late String referenceRawJson;
    late LocationDto referenceDto;

    setUp(() {
      referenceDto = locationDto;

      referenceRawJson = json.encode(locationMap);
    });

    test('should create LocationDto instance to/from JSON', () {
      final createdDto = LocationDto.fromRawJson(referenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}
