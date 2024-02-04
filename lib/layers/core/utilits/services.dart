List<int> extractIdsFromUrls(List<String>? urls) {
  if (urls != null && urls.isNotEmpty) {
    return urls.map((url) {
      final parts = url.split('/');
      return int.parse(parts.last);
    }).toList();
  }
  return [];
}
