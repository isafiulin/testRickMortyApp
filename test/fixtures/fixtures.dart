// ignore_for_file: avoid_redundant_argument_values

import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/data/dto/character_dto.dart';
import 'package:testrickmortyapp/layers/data/dto/location_dto.dart';

final characterDto = CharacterDto(
  id: 1,
  name: 'Rick Sanchez',
  status: 'Alive',
  species: 'Human',
  type: 'Super genius',
  gender: 'Male',
  origin: LocationDto(name: 'Earth', url: 'https://example.com/earth'),
  location: LocationDto(name: 'Earth', url: 'https://example.com/earth'),
  image: 'https://example.com/rick.png',
  episode: ['https://example.com/episode1', 'https://example.com/episode2'],
  url: 'https://example.com/character/1',
  created: DateTime.parse('2022-01-01T12:00:00Z'),
);

final characterList1 = [
  CharacterDto(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: 'Super genius',
    gender: 'Male',
    origin: LocationDto(
        name: 'Earth', url: 'https://rickandmortyapi.com/api/location/1'),
    location: LocationDto(
        name: 'Citadel of Ricks',
        url: 'https://rickandmortyapi.com/api/location/3'),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2'
    ],
    url: 'https://rickandmortyapi.com/api/character/1',
    created: DateTime.parse('2022-01-01T12:00:00Z'),
  ),
  CharacterDto(
    id: 2,
    name: 'Morty Smith',
    status: 'Alive',
    species: 'Human',
    type: 'Sidekick',
    gender: 'Male',
    origin: LocationDto(
        name: 'Earth', url: 'https://rickandmortyapi.com/api/location/1'),
    location: LocationDto(
        name: 'Earth', url: 'https://rickandmortyapi.com/api/location/1'),
    image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
    episode: [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2'
    ],
    url: 'https://rickandmortyapi.com/api/character/2',
    created: DateTime.parse('2022-01-02T12:00:00Z'),
  ),
];

final characterMap1 = [
  {
    'id': 1,
    'name': 'Rick Sanchez',
    'status': 'Alive',
    'species': 'Human',
    'type': 'Super genius',
    'gender': 'Male',
    'origin': {
      'name': 'Earth',
      'url': 'https://rickandmortyapi.com/api/location/1'
    },
    'location': {
      'name': 'Citadel of Ricks',
      'url': 'https://rickandmortyapi.com/api/location/3'
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    'url': 'https://rickandmortyapi.com/api/character/1',
    'created': '2022-01-01T12:00:00Z'
  },
  {
    'id': 2,
    'name': 'Morty Smith',
    'status': 'Alive',
    'species': 'Human',
    'type': 'Sidekick',
    'gender': 'Male',
    'origin': {
      'name': 'Earth',
      'url': 'https://rickandmortyapi.com/api/location/1'
    },
    'location': {
      'name': 'Earth',
      'url': 'https://rickandmortyapi.com/api/location/1'
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    'url': 'https://rickandmortyapi.com/api/character/2',
    'created': '2022-01-02T12:00:00Z'
  }
];

final characterMap2 = [
  {
    'id': 3,
    'name': 'Summer Smith',
    'status': 'Alive',
    'species': 'Human',
    'type': 'Teenager',
    'gender': 'Female',
    'origin': {'name': 'Earth', 'url': 'https://example.com/earth'},
    'location': {'name': 'Earth', 'url': 'https://example.com/earth'},
    'image': 'https://rickandmortyapi.com/api/character/avatar/3.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/6',
      'https://rickandmortyapi.com/api/episode/7',
    ],
    'url': 'https://rickandmortyapi.com/api/character/3',
    'created': '2022-01-03T12:00:00Z'
  },
  {
    'id': 4,
    'name': 'Jerry Smith',
    'status': 'Alive',
    'species': 'Human',
    'type': 'Father',
    'gender': 'Male',
    'origin': {'name': 'Earth', 'url': 'https://example.com/earth'},
    'location': {'name': 'Earth', 'url': 'https://example.com/earth'},
    'image': 'https://rickandmortyapi.com/api/character/avatar/4.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/6',
      'https://rickandmortyapi.com/api/episode/7',
    ],
    'url': 'https://rickandmortyapi.com/api/character/4',
    'created': '2022-01-04T12:00:00Z'
  },
];

final characterList2 = [
  CharacterDto(
    id: 3,
    name: 'Summer Smith',
    status: 'Alive',
    species: 'Human',
    type: 'Teenager',
    gender: 'Female',
    origin: LocationDto(name: 'Earth', url: 'https://example.com/earth'),
    location: LocationDto(name: 'Earth', url: 'https://example.com/earth'),
    image: 'https://rickandmortyapi.com/api/character/avatar/3.jpeg',
    episode: [
      'https://rickandmortyapi.com/api/episode/6',
      'https://rickandmortyapi.com/api/episode/7'
    ],
    url: 'https://rickandmortyapi.com/api/character/3',
    created: DateTime.parse('2022-01-03T12:00:00Z'),
  ),
  CharacterDto(
    id: 4,
    name: 'Jerry Smith',
    status: 'Alive',
    species: 'Human',
    type: 'Father',
    gender: 'Male',
    origin: LocationDto(name: 'Earth', url: 'https://example.com/earth'),
    location: LocationDto(name: 'Earth', url: 'https://example.com/earth'),
    image: 'https://rickandmortyapi.com/api/character/avatar/4.jpeg',
    episode: [
      'https://rickandmortyapi.com/api/episode/6',
      'https://rickandmortyapi.com/api/episode/7'
    ],
    url: 'https://rickandmortyapi.com/api/character/4',
    created: DateTime.parse('2022-01-04T12:00:00Z'),
  ),
];

final paginatedResponseResult1NextNotNull = PaginatedResponseResult(
    count: characterMap1.length, next: 'nextPage', result: characterMap1);
final paginatedResponseResult1NextNull = PaginatedResponseResult(
    count: characterMap2.length, next: null, result: characterMap2);
