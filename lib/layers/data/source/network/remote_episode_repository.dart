import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/api/api.dart';
import 'package:testrickmortyapp/layers/core/api/network_server_config.dart';
import 'package:testrickmortyapp/layers/core/api_response/api_response.dart';
import 'package:testrickmortyapp/layers/core/constants/status_code.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';

abstract class RemoteEpisodeRepository {
  Future<PaginatedResponseResult?> fetchEpisodes(
      {int page = 0, EpisodeFilters? filters});
}

@LazySingleton(as: RemoteEpisodeRepository)
class RemoteEpisodeRepositoryImpl implements RemoteEpisodeRepository {
  RemoteEpisodeRepositoryImpl({required this.apiConsumer});
  final ApiConsumer apiConsumer;

  @override
  Future<PaginatedResponseResult?> fetchEpisodes(
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
      final responseResult = PaginatedResponseResult.fromMap(
          response.data as Map<String, dynamic>);

      return responseResult;
    }
    //  API responds with 404 when reached the end
    else if (response.statusCode == StatusCodeConstant.statuNotFound) {
      return null;
    } else {
      throw const ErrorException(message: '');
    }
  }
}
