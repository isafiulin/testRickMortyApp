import 'dart:convert';

import 'package:testrickmortyapp/layers/data/dto/character_dto.dart';
import 'package:testrickmortyapp/layers/data/dto/episodes_dto.dart';

/// A codec that can serialize both [ComplexData1] and [ComplexData2].
class MyExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const MyExtraCodec();
  @override
  Converter<Object?, Object?> get decoder => const _MyExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _MyExtraEncoder();
}

class _MyExtraDecoder extends Converter<Object?, Object?> {
  const _MyExtraDecoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final List<Object?> inputAsList = input as List<Object?>;
    if (inputAsList[0] == 'CharacterDto') {
      return CharacterDto();
    }
    if (inputAsList[0] == 'EpisodeDto') {
      return EpisodeDto();
    }

    throw FormatException('Unable to parse input: $input');
  }
}

class _MyExtraEncoder extends Converter<Object?, Object?> {
  const _MyExtraEncoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    switch (input) {
      case CharacterDto _:
        return <CharacterDto>[];
      case EpisodeDto _:
        return <EpisodeDto>[];
      default:
        throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
