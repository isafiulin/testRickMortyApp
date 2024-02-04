import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/data/source/local/local_episodes_storage.dart';
import 'package:testrickmortyapp/layers/data/source/network/remote_episode_repository.dart';
import 'package:testrickmortyapp/layers/domain/repository/episode_repository.dart';

@LazySingleton(as: EpisodeRepository)
class EpisodeRepositoryImpl implements EpisodeRepository {
  EpisodeRepositoryImpl({
    required RemoteEpisodeRepository remoteEpisodeRepository,
    required LocalEpisodeStorage localEpisodeStorage,
  })  : _remoteEpisodeRepository = remoteEpisodeRepository,
        _localEpisodeStorage = localEpisodeStorage;
  final RemoteEpisodeRepository _remoteEpisodeRepository;
  final LocalEpisodeStorage _localEpisodeStorage;

  @override
  Future<PaginatedResponseResult?> getEpisodes(
      {int page = 0, EpisodeFilters? filters}) async {
    if (filters == null) {
      final cachedList = _localEpisodeStorage.loadPage(page: page);

      if (cachedList != null) {
        return cachedList;
      }
    }

    final fetchedList = await _remoteEpisodeRepository.fetchEpisodes(
        page: page, filters: filters);
    if (filters == null) {
      await _localEpisodeStorage.savePage(page: page, data: fetchedList);
    }
    return fetchedList;
  }
}
