import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/api/api.dart';
import 'package:testrickmortyapp/layers/core/api/network_server_config.dart';
import 'package:testrickmortyapp/layers/core/api_response/api_response.dart';
import 'package:testrickmortyapp/layers/core/constants/status_code.dart';
import 'package:testrickmortyapp/layers/core/models/filters.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';
import 'package:testrickmortyapp/layers/data/dto/character_dto.dart';

abstract class RemoteCharacterRepository {
  Future<PaginatedResponseResult?> loadCharacters(
      {int page = 0, CharacterFilters? filter});
  Future<List<CharacterDto>?> loadCharactersByIds({required List<int> listIds});
}

@LazySingleton(as: RemoteCharacterRepository)
class RemoteCharacterRepositoryImpl implements RemoteCharacterRepository {
  RemoteCharacterRepositoryImpl({required this.apiConsumer});
  final ApiConsumer apiConsumer;

  @override
  Future<PaginatedResponseResult?> loadCharacters(
      {int page = 0, CharacterFilters? filter}) async {
    String url = '${ServerAddresses.character}?page=$page';

    if (filter?.name != null) {
      url += '&name=${filter?.name}';
    }
    if (filter?.getFirstTrueStatusKey() != null) {
      url += '&status=${filter?.getFirstTrueStatusKey()}';
    }
    if (filter?.getFirstTrueGenderKey() != null) {
      url += '&gender=${filter?.getFirstTrueGenderKey()}';
    }
    if (filter?.getFirstTrueSpeciesKey() != null) {
      url += '&species=${filter?.getFirstTrueSpeciesKey()}';
    }
    final response = await apiConsumer.get(url: url);
    if (response.statusCode == StatusCodeConstant.statusOK200) {
      //TODO добавить дополнительно точную проверку
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

  @override
  Future<List<CharacterDto>?> loadCharactersByIds(
      {required List<int> listIds}) async {
    final String url = '${ServerAddresses.character}${listIds.join(',')}';

    final response = await apiConsumer.get(url: url);
    if (response.statusCode == StatusCodeConstant.statusOK200) {
      if (response.data is List) {
        final l = (response.data as List)
            .map((e) => CharacterDto.fromMap(e as Map<String, dynamic>))
            .toList();
        return l;
      }
      if (response.data is Map<String, dynamic>) {
        //TODO есть кейсы, когда возвращается один обьект , но мапкой
        return null;
      }
      return null;
    }
    //  API responds with 404 when reached the end
    else if (response.statusCode == StatusCodeConstant.statuNotFound) {
      return null;
    } else {
      throw const ErrorException(message: '');
    }
  }
}
