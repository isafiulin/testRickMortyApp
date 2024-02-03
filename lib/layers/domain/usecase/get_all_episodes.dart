import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/domain/repository/episode_repository.dart';

@LazySingleton()
class GetAllEpisodes {
  GetAllEpisodes({
    required EpisodeRepository repository,
  }) : _repository = repository;

  final EpisodeRepository _repository;

  Future<PaginatedResponseResult?> call(
      {int page = 0, EpisodeFilters? filters}) async {

    final list = await _repository.getEpisodes(page: page, filters: filters);
    return list;
  }
}
