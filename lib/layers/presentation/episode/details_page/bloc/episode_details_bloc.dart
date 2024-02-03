import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';

part 'episode_details_event.dart';

part 'episode_details_state.dart';

class EpisodeDetailsBloc
    extends Bloc<EpisodeDetailsEvent, EpisodeDetailsState> {
  EpisodeDetailsBloc({required Episode episode})
      : super(EpisodeDetailsState(episode: episode));
}
