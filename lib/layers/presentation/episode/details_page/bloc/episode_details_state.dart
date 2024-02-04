part of 'episode_details_bloc.dart';

class EpisodeDetailsState with EquatableMixin {
  EpisodeDetailsState({
    required this.episode,
    this.characters,
  });

  final Episode episode;
  final List<Character>? characters;

  EpisodeDetailsState copyWith({
    List<Character>? characters,
    Episode? episode,
  }) {
    return EpisodeDetailsState(
      characters: characters ?? this.characters,
      episode: episode ?? this.episode,
    );
  }

  @override
  List<Object?> get props => [episode, characters];
}
