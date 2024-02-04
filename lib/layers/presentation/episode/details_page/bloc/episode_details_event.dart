part of 'episode_details_bloc.dart';

sealed class EpisodeDetailsEvent extends Equatable {
  const EpisodeDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class FetchCharactersEvent extends EpisodeDetailsEvent {
  const FetchCharactersEvent({this.episode});
  final Episode? episode;
}
