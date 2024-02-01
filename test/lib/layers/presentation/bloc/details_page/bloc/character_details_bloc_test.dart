import 'package:flutter_test/flutter_test.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/presentation/character/details_page/bloc/character_details_bloc.dart';

import '../../../../../../fixtures/fixtures.dart';

void main() {
  group('CharacterDetailsBloc', () {
    test('initial state is correct', () {
      final Character c = characterList1.first;

      final expected = CharacterDetailsState(character: c);
      final initial = CharacterDetailsBloc(character: c).state;

      expect(initial, expected);
    });
  });
}
