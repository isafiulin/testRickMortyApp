import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/api/api.dart';
import 'package:testrickmortyapp/layers/core/api/network_server_config.dart';
import 'package:testrickmortyapp/layers/core/api_response/api_response.dart';
import 'package:testrickmortyapp/layers/core/constants/status_code.dart';
import 'package:testrickmortyapp/layers/core/models/response_result.dart';

abstract class RemoteCharacterRepository {
  Future<PaginatedResponseResult?> loadCharacters({int page = 0});
}

@LazySingleton(as: RemoteCharacterRepository)
class RemoteCharacterRepositoryImpl implements RemoteCharacterRepository {
  RemoteCharacterRepositoryImpl({required this.apiConsumer});
  final ApiConsumer apiConsumer;

  @override
  Future<PaginatedResponseResult?> loadCharacters({int page = 0}) async {
    final String url = '${ServerAddresses.character}?page=$page';
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
}
