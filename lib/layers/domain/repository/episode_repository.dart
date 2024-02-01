import 'package:testrickmortyapp/layers/domain/entity/episode.dart';

abstract class EpisodeRepository {
  Future<List<Episode>> getEpisodes({int page = 0});
}
