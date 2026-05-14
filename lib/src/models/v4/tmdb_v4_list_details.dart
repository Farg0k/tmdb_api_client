import 'tmdb_v4_list_item.dart';

/// [TmdbListV4Details] represents the full information about a v4 list.
class TmdbListV4Details {
  final String? backdropPath;
  final int id;
  final int page;
  final List<TmdbListV4Item> results;
  final int totalPages;
  final int totalResults;
  final String name;
  final String description;
  final String iso_639_1;
  final String? posterPath;
  final bool public;
  final double revenue;
  final int runtime;
  final String sortBy;

  // Appended resources (optional)
  final List<Map<String, dynamic>>? comments;
  final List<Map<String, dynamic>>? votes;
  final List<Map<String, dynamic>>? watchers;

  TmdbListV4Details({
    this.backdropPath,
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
    required this.name,
    required this.description,
    required this.iso_639_1,
    this.posterPath,
    required this.public,
    required this.revenue,
    required this.runtime,
    required this.sortBy,
    this.comments,
    this.votes,
    this.watchers,
  });

  factory TmdbListV4Details.fromJson(Map<String, dynamic> json) {
    return TmdbListV4Details(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List)
          .map((i) => TmdbListV4Item.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iso_639_1: json['iso_639_1'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      public: json['public'] as bool? ?? false,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] as int? ?? 0,
      sortBy: json['sort_by'] as String? ?? '',
      // Appended resources
      comments: (json['comments'] as List?)?.cast<Map<String, dynamic>>(),
      votes: (json['votes'] as List?)?.cast<Map<String, dynamic>>(),
      watchers: (json['watchers'] as List?)?.cast<Map<String, dynamic>>(),
    );
  }
}
