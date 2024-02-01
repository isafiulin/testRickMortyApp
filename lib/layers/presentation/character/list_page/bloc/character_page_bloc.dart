import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:testrickmortyapp/layers/domain/entity/character.dart';
import 'package:testrickmortyapp/layers/domain/usecase/get_all_characters.dart';

part 'character_page_event.dart';
part 'character_page_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterPageBloc extends Bloc<CharacterPageEvent, CharacterPageState> {
  CharacterPageBloc({
    required GetAllCharacters getAllCharacters,
  })  : _getAllCharacters = getAllCharacters,
        super(const CharacterPageState()) {
    on<FetchNextPageEvent>(
      _fetchNextPage,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<RefreshPageEvent>(
      _refreshPage,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  final GetAllCharacters _getAllCharacters;
  Future<void> _refreshPage(event, Emitter<CharacterPageState> emit) async {
    emit(state.copyWith(status: CharacterPageStatus.loading));

    //TODO добавил для проверки отображения загрузки
    await Future.delayed(const Duration(seconds: 1));

    final list = await _getAllCharacters(page: 1);
    emit(
      CharacterPageState(
          status: CharacterPageStatus.success,
          characters: list,
          hasReachedEnd: list.isEmpty,
          currentPage: 2),
    );
  }

  Future<void> _fetchNextPage(event, Emitter<CharacterPageState> emit) async {
    if (state.hasReachedEnd) {
      return;
    }
    emit(state.copyWith(status: CharacterPageStatus.loading));

    final list = await _getAllCharacters(page: state.currentPage);

    emit(
      state.copyWith(
        status: CharacterPageStatus.success,
        characters: List.of(state.characters)..addAll(list),
        hasReachedEnd: list.isEmpty,
        currentPage: state.currentPage + 1,
      ),
    );
  }
}
