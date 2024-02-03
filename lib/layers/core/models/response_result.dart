// ignore_for_file: sort_constructors_first

import 'dart:convert';

class PaginatedResponseResult {
  final int count;
  final String? next;
  final List result;
  PaginatedResponseResult({
    required this.count,
    this.next,
    required this.result,
  });

  PaginatedResponseResult copyWith({
    int? count,
    String? next,
    List? result,
  }) {
    return PaginatedResponseResult(
      count: count ?? this.count,
      next: next ?? this.next,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'result': result,
    };
  }

  String toRawJson() => json.encode(toMap());
  factory PaginatedResponseResult.fromJsonString(String jsonString) {
    // Parse the JSON string to a map
    final Map<String, dynamic> map =
        json.decode(jsonString) as Map<String, dynamic>;
    return PaginatedResponseResult(
        count: map['count'] as int,
        next: map['next'] != null ? map['next'] as String? : null,
        result: (List.from(map['result'] as List).isNotEmpty)
            ? List.from(
                map['result'] as List,
              )
            : []);
  }

  factory PaginatedResponseResult.fromJson(String jsonString) {
    // Parse the JSON string to a map
    final Map<String, dynamic> map =
        json.decode(jsonString) as Map<String, dynamic>;
    return PaginatedResponseResult(
        count: map['info']['count'] as int,
        next:
            map['info']['next'] != null ? map['info']['next'] as String? : null,
        result: (List.from(map['results'] as List).isNotEmpty)
            ? List.from(
                map['results'] as List,
              )
            : []);
  }

  factory PaginatedResponseResult.fromMap(Map<String, dynamic> map) {
    return PaginatedResponseResult(
        count: map['info']['count'] as int,
        next:
            map['info']['next'] != null ? map['info']['next'] as String? : null,
        result: (List.from(map['results'] as List).isNotEmpty)
            ? List.from(
                map['results'] as List,
              )
            : []);
  }
}
