import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/data/source/local/local_episodes_storage.dart';
import 'package:testrickmortyapp/layers/data/source/network/remote_episode_repository.dart';
import 'package:testrickmortyapp/layers/domain/entity/episode.dart';
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
  Future<List<Episode>> getEpisodes({int page = 0}) async {
    final cachedList = _localEpisodeStorage.loadPage(page: page);
    if (cachedList.isNotEmpty) {
      return cachedList as List<Episode>;
    }

    final fetchedList =
        await _remoteEpisodeRepository.fetchEpisodes(page: page);
    await _localEpisodeStorage.savePage(page: page, list: fetchedList);
    return fetchedList;
  }
}
