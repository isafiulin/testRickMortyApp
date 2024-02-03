import 'package:testrickmortyapp/layers/core/models/response_result.dart';

abstract class LocalStorage {
  Future<bool> savePage({
    PaginatedResponseResult? data,
    required int page,
  });

  PaginatedResponseResult? loadPage({required int page});
}
