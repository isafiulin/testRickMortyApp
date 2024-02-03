import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';

abstract class EpisodeRepository {
  Future<PaginatedResponseResult?> getEpisodes(
      {int page = 0, EpisodeFilters? filters});
}
