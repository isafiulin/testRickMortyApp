// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:testrickmortyapp/layers/domain/entity/location.dart';

class LocationDto extends Location {
  LocationDto({
    super.name,
    super.url,
  });

  factory LocationDto.fromRawJson(String str) =>
      LocationDto.fromMap(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toMap());

  factory LocationDto.fromMap(Map<String, dynamic> json) => LocationDto(
        name: json['name'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };

  static LocationDto fromLocation(Location location) {
    return LocationDto(
      name: location.name,
      url: location.url,
    );
  }

  Location toLocation() {
    return Location(
      name: name,
      url: url,
    );
  }
}
