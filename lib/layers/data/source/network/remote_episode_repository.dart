import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/api/api.dart';
import 'package:testrickmortyapp/layers/core/api/network_server_config.dart';
import 'package:testrickmortyapp/layers/core/constants/status_code.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/data/dto/episodes_dto.dart';

abstract class RemoteEpisodeRepository {
  Future<List<EpisodeDto>> fetchEpisodes(
      {int page = 0, EpisodeFilters? filters});
}

@LazySingleton(as: RemoteEpisodeRepository)
class RemoteEpisodeRepositoryImpl implements RemoteEpisodeRepository {
  RemoteEpisodeRepositoryImpl({required this.apiConsumer});
  final ApiConsumer apiConsumer;

  @override
  Future<List<EpisodeDto>> fetchEpisodes(
      {int page = 0, EpisodeFilters? filters}) async {
    String url = '${ServerAddresses.episode}?page=$page';

    if (filters?.name != null && filters?.name != '') {
      url += '&name=${filters?.name}';
    }
    if (filters?.name != null && filters?.name != '') {
      url += '&episode=${filters?.episode}';
    }
    final response = await apiConsumer.get(url: url);
    if (response.statusCode == StatusCodeConstant.statusOK200) {
      final responseList = (response.data['results'] as List)
          .map((e) => EpisodeDto.fromMap(e as Map<String, dynamic>))
          .toList();
      return responseList;
    }
    //  API responds with 404 when reached the end
    else if (response.statusCode == StatusCodeConstant.statuNotFound) {
      return [];
    } else {
      print(response.message);
      return [];
      // throw const ErrorException(message: '');
    }
  }
}
