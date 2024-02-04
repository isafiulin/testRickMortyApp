import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/data/dto/episodes_dto.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_episodes.dart';

part 'episode_page_event.dart';
part 'episode_page_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EpisodePageBloc extends Bloc<EpisodePageEvent, EpisodePageState> {
  EpisodePageBloc({
    required GetAllEpisodes getAllEpisodes,
  })  : _getAllEpisodes = getAllEpisodes,
        super(const EpisodePageState()) {
    on<FetchNextPageEvent>(
      _fetchNextPage,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<RefreshPageEvent>(
      _refreshPage,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  final GetAllEpisodes _getAllEpisodes;
  Future<void> _refreshPage(
      RefreshPageEvent event, Emitter<EpisodePageState> emit) async {
    emit(state.copyWith(status: EpisodePageStatus.initial));
    bool hasReachedEnd = false;

    //TODO добавил для проверки отображения загрузки
    await Future.delayed(const Duration(seconds: 1));
    List<Episode> list = [];

    try {
      final result = await _getAllEpisodes.call(page: 1, filters: event.filter);
      if (result != null) {
        list = result.result
            .map((e) => EpisodeDto.fromMap(e as Map<String, dynamic>))
            .toList();
        hasReachedEnd = result.next == null;
      }
    } catch (e) {
      log(e.toString());
      return emit(
        state.copyWith(
            status: EpisodePageStatus.failure,
            episodes: list,
            hasReachedEnd: list.isEmpty,
            currentPage: 1),
      );
    }

    emit(
      state.copyWith(
          status: EpisodePageStatus.success,
          episodes: list,
          hasReachedEnd: hasReachedEnd,
          currentPage: 2),
    );
  }

  Future<void> _fetchNextPage(event, Emitter<EpisodePageState> emit) async {
    List<Episode> list = [];
    if (state.episodes.isEmpty) {
      emit(state.copyWith(status: EpisodePageStatus.initial));
    } else {
      emit(state.copyWith(status: EpisodePageStatus.loading));
    }

    if (state.hasReachedEnd) {
      return;
    }

    try {
      final result = await _getAllEpisodes.call(page: state.currentPage);
      if (result != null) {
        list = result.result
            .map((e) => EpisodeDto.fromMap(e as Map<String, dynamic>))
            .toList();
      }

      emit(
        state.copyWith(
          status: EpisodePageStatus.success,
          episodes: List.of(state.episodes)..addAll(list),
          hasReachedEnd: result?.next == null,
          currentPage:
              result?.next == null ? state.currentPage : state.currentPage + 1,
        ),
      );
    } catch (e) {
      log(e.toString());

      return emit(
        state.copyWith(
            status: EpisodePageStatus.failure,
            episodes: List.of(state.episodes)..addAll(list),
            hasReachedEnd: list.isEmpty,
            currentPage: 1),
      );
    }
  }
}
