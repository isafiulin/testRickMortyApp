import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:testrickmortyapp/layers/core/utilits/services.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_characters_by_id.dart';

part 'episode_details_event.dart';

part 'episode_details_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EpisodeDetailsBloc
    extends Bloc<EpisodeDetailsEvent, EpisodeDetailsState> {
  EpisodeDetailsBloc({
    required Episode episode,
    required GetCharactersByIDs getCharactersByIDs,
  })  : _getCharactersByIDs = getCharactersByIDs,
        super(EpisodeDetailsState(episode: episode)) {
    on<FetchCharactersEvent>(
      _fetchCharacters,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }
  final GetCharactersByIDs _getCharactersByIDs;

  Future<void> _fetchCharacters(
      FetchCharactersEvent event, Emitter<EpisodeDetailsState> emit) async {
    final List<Character> list = [];
    final List<int> listIds = [];

    listIds.addAll(extractIdsFromUrls(event.episode?.characters));

    if (listIds.isEmpty) {
      return;
    }

    try {
      final result = await _getCharactersByIDs.call(listIds: listIds);
      if (result != null) {
        list.addAll(result);
      }
      emit(state.copyWith(characters: list));
    } catch (e) {
      log(e.toString());
    }
  }
}
