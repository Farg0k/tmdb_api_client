/// [MediaSummary] is a base class for common properties between Movie and TV summaries.
abstract class MediaSummary {
  final int id;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final double? rating; // Added for rated content
  final double popularity; // Added for lists
  final String originalLanguage;
  final List<int> genreIds;
  final bool adult;

  MediaSummary({
    required this.id,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    this.rating,
    required this.popularity,
    required this.originalLanguage,
    required this.genreIds,
    required this.adult,
  });
}

/// [MovieSummary] represents a concise version of movie data returned in lists.
class MovieSummary extends MediaSummary {
  final String title;
  final String originalTitle;
  final String releaseDate;
  final bool video;

  MovieSummary({
    required super.id,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    super.rating,
    required super.popularity,
    required super.originalLanguage,
    required super.genreIds,
    required super.adult,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.video,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> json) {
    return MovieSummary(
      id: json['id'] as int,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList() ??
          [],
      adult: json['adult'] as bool? ?? false,
      title: json['title'] as String,
      originalTitle: json['original_title'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      video: json['video'] as bool? ?? false,
    );
  }
}

/// [TvSummary] represents a concise version of TV show data returned in lists.
class TvSummary extends MediaSummary {
  final String name;
  final String originalName;
  final String firstAirDate;
  final List<String> originCountry;

  TvSummary({
    required super.id,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    super.rating,
    required super.popularity,
    required super.originalLanguage,
    required super.genreIds,
    required super.adult,
    required this.name,
    required this.originalName,
    required this.firstAirDate,
    required this.originCountry,
  });

  factory TvSummary.fromJson(Map<String, dynamic> json) {
    return TvSummary(
      id: json['id'] as int,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList() ??
          [],
      adult: json['adult'] as bool? ?? false,
      name: json['name'] as String,
      originalName: json['original_name'] as String? ?? '',
      firstAirDate: json['first_air_date'] as String? ?? '',
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
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
      results: (json['results'] as List)
          .map((i) => fromJsonT(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}

/// [TmdbMediaType] defines the types of media supported by TMDB.
enum TmdbMediaType { movie, tv }

extension MediaTypeExtension on TmdbMediaType {
  String get value => name;
}