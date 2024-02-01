abstract class LocalStorage {
  Future<bool> savePage({
    required int page,
    required List<dynamic> list,
  });

  List<dynamic> loadPage({required int page});
}
