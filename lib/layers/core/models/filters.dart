import 'package:testrickmortyapp/layers/core/utilits/enums.dart';

class EpisodeFilters {
  EpisodeFilters({this.episode = '', this.name = ''});
  final String? name;
  final String? episode;
}

class CharacterFilters {
  CharacterFilters({
    this.name = '',
    this.status,
    this.species,
    this.gender,
  });
  final String name;
  Map<CharacterStatus, bool>? status;
  Map<CharacterSpecies, bool>? species;
  Map<CharacterGender, bool>? gender;

  void setOnlyOneSpeciesTrue(CharacterSpecies selectedSpecies) {
    for (final specie in CharacterSpecies.values) {
      species?[specie] = (specie == selectedSpecies);
    }
  }

  void setOnlyOneStatusTrue(CharacterStatus selectedStatus) {
    for (final statusValue in CharacterStatus.values) {
      status?[statusValue] = (statusValue == selectedStatus);
    }
  }

  void setOnlyOneGenderTrue(CharacterGender selectedSpecies) {
    for (final specie in CharacterGender.values) {
      gender?[specie] = (specie == selectedSpecies);
    }
  }

  String? getFirstTrueGenderKey() {
    if (gender != null) {
      for (final entry in gender!.entries) {
        if (entry.value) {
          return entry.key.name; // Return the first key with a true value
        }
      }
      return null; // Return null if no true value is found
    }

    return null;
  }

  String? getFirstTrueSpeciesKey() {
    if (species != null) {
      for (final entry in species!.entries) {
        if (entry.value) {
          return entry.key.name; // Return the first key with a true value
        }
      }
      return null; // Return null if no true value is found
    }

    return null;
  }

  String? getFirstTrueStatusKey() {
    if (status != null) {
      for (final entry in status!.entries) {
        if (entry.value) {
          return entry.key.name; // Return the first key with a true value
        }
      }
      return null; // Return null if no true value is found
    }

    return null;
  }

  void resetMapValues<T>(Map<T, bool>? map) {
    if (map != null) {
      map.updateAll((key, value) => false);
    }
  }

  void resetAll() {
    resetMapValues(status);
    resetMapValues(species);
    resetMapValues(gender);
  }
}
