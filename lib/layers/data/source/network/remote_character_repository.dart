import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/api/api.dart';
import 'package:testrickmortyapp/layers/core/api/network_server_config.dart';
import 'package:testrickmortyapp/layers/core/constants/status_code.dart';
import 'package:testrickmortyapp/layers/data/dto/character_dto.dart';

abstract class RemoteCharacterRepository {
  Future<List<CharacterDto>> loadCharacters({int page = 0});
}

@LazySingleton(as: RemoteCharacterRepository)
class RemoteCharacterRepositoryImpl implements RemoteCharacterRepository {
  RemoteCharacterRepositoryImpl({required this.apiConsumer});
  final ApiConsumer apiConsumer;

  @override
  Future<List<CharacterDto>> loadCharacters({int page = 0}) async {
    final String url = '${ServerAddresses.character}?page=$page';
    final response = await apiConsumer.get(url: url);
    if (response.statusCode == StatusCodeConstant.statusOK200) {
      final responseList = (response.data['results'] as List)
          .map((e) => CharacterDto.fromMap(e as Map<String, dynamic>))
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
