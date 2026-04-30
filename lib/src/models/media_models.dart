/// [MediaSummary] is a base class for common properties between Movie and TV summaries.
abstract class MediaSummary {
  final int id;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;

  MediaSummary({
    required this.id,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
  });
}

/// [MovieSummary] represents a concise version of movie data returned in lists.
class MovieSummary extends MediaSummary {
  final String title;
  final String releaseDate;

  MovieSummary({
    required super.id,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    required this.title,
    required this.releaseDate,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> json) {
    return MovieSummary(
      id: json['id'] as int,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      title: json['title'] as String,
      releaseDate: json['release_date'] as String? ?? '',
    );
  }
}

/// [TvSummary] represents a concise version of TV show data returned in lists.
class TvSummary extends MediaSummary {
  final String name;
  final String firstAirDate;

  TvSummary({
    required super.id,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    required this.name,
    required this.firstAirDate,
  });

  factory TvSummary.fromJson(Map<String, dynamic> json) {
    return TvSummary(
      id: json['id'] as int,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      name: json['name'] as String,
      firstAirDate: json['first_air_date'] as String? ?? '',
    );
  }
}

/// [TmdbResponsePage] is a generic wrapper for paginated responses from TMDB.
class TmdbResponsePage<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  TmdbResponsePage({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbResponsePage.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return TmdbResponsePage<T>(
      page: json['page'] as int,
      results: (json['results'] as List).map((i) => fromJsonT(i as Map<String, dynamic>)).toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}

/// [MediaType] defines the types of media supported by TMDB.
enum MediaType { movie, tv }

extension MediaTypeExtension on MediaType {
  String get value => name;
}
