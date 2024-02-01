// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:testrickmortyapp/layers/domain/entity/episode.dart';

class EpisodeDto extends Episode {
  EpisodeDto({
    super.id,
    super.name,
    super.airDate,
    super.episode,
    super.characters,
    super.url,
    super.created,
  });

  factory EpisodeDto.fromRawJson(String str) =>
      EpisodeDto.fromMap(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toMap());

  factory EpisodeDto.fromMap(Map<String, dynamic> json) => EpisodeDto(
        id: json['id'] as int?,
        name: json['name'] as String?,
        airDate: json['air_date'] as String?,
        episode: json['episode'] as String?,
        characters: List<String>.from(
            json['characters'].map((x) => x) as Iterable<dynamic>),
        url: json['url'] as String?,
        created: DateTime.parse(json['created'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'air_date': airDate,
        'episode': episode,
        'characters': List<dynamic>.from(characters!.map((x) => x)),
        'url': url,
        'created': created?.toIso8601String(),
      };
}
