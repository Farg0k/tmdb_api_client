import 'tmdb_v4_list_summary.dart';

/// [TmdbAccountV4ListsResponse] represents the response for user's v4 lists.
class TmdbAccountV4ListsResponse {
  final int page;
  final List<TmdbListV4Summary> results;
  final int totalPages;
  final int totalResults;

  TmdbAccountV4ListsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbAccountV4ListsResponse.fromJson(Map<String, dynamic> json) {
    return TmdbAccountV4ListsResponse(
      page: json['page'] as int,
      results: (json['results'] as List)
          .map((i) => TmdbListV4Summary.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
