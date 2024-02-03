part of 'episode_details_bloc.dart';

class EpisodeDetailsState with EquatableMixin {
  EpisodeDetailsState({required this.episode});

  final Episode episode;

  @override
  List<Object?> get props => [episode];
}
