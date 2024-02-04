part of 'character_page_bloc.dart';

sealed class CharacterPageEvent extends Equatable {
  const CharacterPageEvent();

  @override
  List<Object?> get props => [];
}

final class FetchNextPageEvent extends CharacterPageEvent {
  const FetchNextPageEvent({this.filter});
  final CharacterFilters? filter;
}

final class RefreshPageEvent extends CharacterPageEvent {
  const RefreshPageEvent({this.isNewSearch = false, this.filter});
  final bool? isNewSearch;
  final CharacterFilters? filter;
}
