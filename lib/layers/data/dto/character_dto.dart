// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:testrickmortyapp/layers/data/dto/location_dto.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';

class CharacterDto extends Character {
  CharacterDto({
    super.id,
    super.name,
    super.status,
    super.species,
    super.type,
    super.gender,
    super.origin,
    super.location,
    super.image,
    super.episode,
    super.url,
    super.created,
  });

  factory CharacterDto.fromRawJson(String str) =>
      CharacterDto.fromMap(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toMap());

  factory CharacterDto.fromMap(Map<String, dynamic> json) => CharacterDto(
        id: json['id'] as int?,
        name: json['name'] as String?,
        status: json['status'] as String?,
        species: json['species'] as String?,
        type: json['type'] as String?,
        gender: json['gender'] as String?,
        origin: json['origin'] == null
            ? null
            : LocationDto.fromMap(json['origin'] as Map<String, dynamic>),
        location: json['location'] == null
            ? null
            : LocationDto.fromMap(json['location'] as Map<String, dynamic>),
        image: json['image'] as String?,
        episode: json['episode'] == null
            ? []
            : List<String>.from(
                json['episode']!.map((x) => x) as Iterable<dynamic>),
        url: json['url'] as String?,
        created: json['created'] == null
            ? null
            : DateTime.parse(json['created'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin':
            origin != null ? LocationDto.fromLocation(origin!).toMap() : null,
        'location': location != null
            ? LocationDto.fromLocation(location!).toMap()
            : null,
        'image': image,
        'episode':
            episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        'url': url,
        'created': created?.toIso8601String(),
      };
}
