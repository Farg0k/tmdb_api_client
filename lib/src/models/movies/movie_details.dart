import '../genre_models.dart';

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
  final List<MovieProductionCompany> productionCompanies;
  final List<MovieProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int? runtime;
  final List<MovieSpokenLanguage> spokenLanguages;
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
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] as int,
      genres: (json['genres'] as List).map((i) => Genre.fromJson(i as Map<String, dynamic>)).toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List)
          .map((i) => MovieProductionCompany.fromJson(i as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List)
          .map((i) => MovieProductionCountry.fromJson(i as Map<String, dynamic>))
          .toList(),
      releaseDate: json['release_date'] as String? ?? '',
      revenue: json['revenue'] as int,
      runtime: json['runtime'] as int?,
      spokenLanguages: (json['spoken_languages'] as List)
          .map((i) => MovieSpokenLanguage.fromJson(i as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      tagline: json['tagline'] as String?,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
  }
}

class MovieProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  MovieProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory MovieProductionCompany.fromJson(Map<String, dynamic> json) {
    return MovieProductionCompany(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String,
    );
  }
}

class MovieProductionCountry {
  final String iso_3166_1;
  final String name;

  MovieProductionCountry({required this.iso_3166_1, required this.name});

  factory MovieProductionCountry.fromJson(Map<String, dynamic> json) {
    return MovieProductionCountry(
      iso_3166_1: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );
  }
}

class MovieSpokenLanguage {
  final String englishName;
  final String iso_639_1;
  final String name;

  MovieSpokenLanguage({required this.englishName, required this.iso_639_1, required this.name});

  factory MovieSpokenLanguage.fromJson(Map<String, dynamic> json) {
    return MovieSpokenLanguage(
      englishName: json['english_name'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
    );
  }
}
