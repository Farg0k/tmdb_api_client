/// [ChangeEntry] represents a single change item in the list of changes.
class ChangeEntry {
  final int id;
  final bool adult;

  ChangeEntry({required this.id, required this.adult});

  factory ChangeEntry.fromJson(Map<String, dynamic> json) {
    return ChangeEntry(
      id: json['id'] as int,
      adult: json['adult'] as bool? ?? false,
    );
  }
}

/// [ChangesResponse] represents a paginated list of change entries.
class ChangesResponse {
  final List<ChangeEntry> results;
  final int page;
  final int totalPages;
  final int totalResults;

  ChangesResponse({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  factory ChangesResponse.fromJson(Map<String, dynamic> json) {
    return ChangesResponse(
      results: (json['results'] as List)
          .map((item) => ChangeEntry.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
