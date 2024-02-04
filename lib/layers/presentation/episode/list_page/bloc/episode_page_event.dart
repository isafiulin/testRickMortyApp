part of 'episode_page_bloc.dart';

sealed class EpisodePageEvent extends Equatable {
  const EpisodePageEvent();

  @override
  List<Object?> get props => [];
}

final class FetchNextPageEvent extends EpisodePageEvent {
  const FetchNextPageEvent({this.isNewSearch = false});
  final bool? isNewSearch;
}

final class RefreshPageEvent extends EpisodePageEvent {
  const RefreshPageEvent({this.filter});
  final EpisodeFilters? filter;
}
