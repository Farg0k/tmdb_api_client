/// [TmdbChangeItem] represents a single attribute change.
class TmdbChangeItem {
  final String id;
  final String action;
  final String time;
  final String? iso_639_1;
  final String? iso_3166_1;
  final dynamic value;
  final dynamic originalValue;

  TmdbChangeItem({
    required this.id,
    required this.action,
    required this.time,
    this.iso_639_1,
    this.iso_3166_1,
    this.value,
    this.originalValue,
  });

  factory TmdbChangeItem.fromJson(Map<String, dynamic> json) {
    return TmdbChangeItem(
      id: json['id'] as String? ?? '',
      action: json['action'] as String? ?? '',
      time: json['time'] as String? ?? '',
      iso_639_1: json['iso_639_1'] as String?,
      iso_3166_1: json['iso_3166_1'] as String?,
      value: json['value'],
      originalValue: json['original_value'],
    );
  }
}

/// [TmdbChangeGroup] represents a group of changes for a specific key (e.g., 'title', 'overview').
class TmdbChangeGroup {
  final String key;
  final List<TmdbChangeItem> items;

  TmdbChangeGroup({required this.key, required this.items});

  factory TmdbChangeGroup.fromJson(Map<String, dynamic> json) {
    return TmdbChangeGroup(
      key: json['key'] as String? ?? '',
      items:
          (json['items'] as List?)
              ?.map((i) => TmdbChangeItem.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// [TmdbChangesResponse] is a wrapper for a list of change groups.
class TmdbChangesResponse {
  final List<TmdbChangeGroup> changes;

  TmdbChangesResponse({required this.changes});

  factory TmdbChangesResponse.fromJson(Map<String, dynamic> json) {
    return TmdbChangesResponse(
      changes:
          (json['changes'] as List?)
              ?.map((i) => TmdbChangeGroup.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
