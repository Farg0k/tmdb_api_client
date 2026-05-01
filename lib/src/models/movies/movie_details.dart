import '../genre_models.dart';
import '../common/tmdb_company.dart';
import '../common/tmdb_country.dart';
import '../common/tmdb_language.dart';

/// [MovieDetails] represents the full information about a movie.
class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection; // Can be a full object or null
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<TmdbCompany> productionCompanies;
  final List<TmdbCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int? runtime;
  final List<TmdbLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetails({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] as int? ?? 0,
      genres:
          (json['genres'] as List?)
              ?.map((i) => Genre.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      productionCompanies:
          (json['production_companies'] as List?)
              ?.map((i) => TmdbCompany.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List?)
              ?.map((i) => TmdbCountry.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      releaseDate: json['release_date'] as String? ?? '',
      revenue: json['revenue'] as int? ?? 0,
      runtime: json['runtime'] as int?,
      spokenLanguages:
          (json['spoken_languages'] as List?)
              ?.map((i) => TmdbLanguage.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String?,
      title: json['title'] as String? ?? '',
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}
