import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:testrickmortyapp/layers/core/api/dio_factory.dart';
import '../dio_response/dio_response.dart';
import 'api_consumer.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  @override
  Future<DioBaseResponse> downloadFile(
      {Map<String, dynamic>? headers,
      ProgressCallback? progressCallback,
      bool processResponse = true,
      required String url,
      required savePath}) async {
    final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();
    try {
      final response = await dio.download(url, savePath,
          options: Options(headers: headers),
          onReceiveProgress: progressCallback);
      final httpResponse = _buildResponse(response);
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> delete(
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      bool processResponse = true,
      required String url}) async {
    try {
      final response = await Dio().delete(url,
          options: Options(headers: headers), queryParameters: params);
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> get(
      {Duration? cacheAge,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      bool processResponse = true,
      required String url}) async {
    try {
      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.get(url,
          options: Options(headers: headers), queryParameters: params);

      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> patch(
      {required Map<String, dynamic> data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      bool processResponse = true,
      required String url}) async {
    try {
      final response = await Dio().patch(url,
          data: data,
          options: Options(headers: headers),
          queryParameters: params);
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> post(
      {Duration? cacheAge,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      bool processResponse = true,
      required String url}) async {
    try {
      final response = await Dio().post(url,
          data: data,
          options: Options(headers: headers),
          queryParameters: params);
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> put(
      {required Map<String, dynamic> data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      bool processResponse = true,
      required String url}) async {
    try {
      final response = await Dio().put(url,
          data: data,
          options: Options(headers: headers),
          queryParameters: params);
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  DioBaseResponse _buildResponse(Response response) {
    return DioBaseResponse(
        data: response.data, statusCode: response.statusCode ?? 400);
  }

  DioBaseResponse _buildResponseWithError(
      DioException error, StackTrace stackTrace) {
    if (error.response?.statusCode != 401) {}

    return DioBaseResponse(
        data: error.response?.data,
        //DIO ERROR SO ITS AN ERROR FROM RESPONSE OF THE API OR FROM DIO ITSELF
        message: _dioError(error),
        statusCode: error.response?.statusCode ?? 400);
  }
}

String? _dioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timed out';

    case DioExceptionType.sendTimeout:
      return 'Request timed out';

    case DioExceptionType.receiveTimeout:
      return 'Response timeout';

    case DioExceptionType.unknown:
      return 'Unknown error';

    case DioExceptionType.connectionError:
      return 'No internet connection';

    case DioExceptionType.cancel:
      return 'request cancelled';

    case DioExceptionType.badCertificate:
      return 'bad certificate';

    case DioExceptionType.badResponse:
      try {
        final int? errCode = error.response?.statusCode;
        switch (errCode) {
          case 400:
            return 'Request timed out'; //dioRequestSyntax

          case 403:
            return 'Server refused to execute'; //dioServerRefusedToExecute

          case 404:
            return 'Server refused to execute'; //dioNotConnectServer

          case 405:
            return 'Request method is forbidden'; //dioRequestForbidden

          case 500:
            return 'Server internal error'; //dioServerInternal

          case 502:
            return 'Invalid request'; //dioInvalidRequest

          case 503:
            return 'Server is down'; //dioServerDown

          case 505:
            return 'Does not support HTTP protocol request'; //dioHttpNotSupport

          default:
            return 'Unknown mistake'; //dioUnknownMistake
        }
      } on Exception catch (_) {
        return 'Unknown error'; //dioUnknownError
      }

    // ignore: no_default_cases
    default:
      return error.message;
  }
}

Future<void> processResponse(DioBaseResponse response) async {
  if (response.statusCode == 401) {}
}
