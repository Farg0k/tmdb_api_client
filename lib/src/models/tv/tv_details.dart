import '../genre_models.dart';
import '../networks/network_details.dart';

/// [TvDetails] represents the full information about a TV series.
class TvDetails {
  final bool adult;
  final String? backdropPath;
  final List<TvCreator> createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final TvLastEpisodeToAir? lastEpisodeToAir;
  final String name;
  final TvLastEpisodeToAir? nextEpisodeToAir;
  final List<NetworkDetails> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<TvProductionCompany> productionCompanies;
  final List<TvProductionCountry> productionCountries;
  final List<TvSeasonSummary> seasons;
  final List<TvSpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvDetails({
    required this.adult,
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetails.fromJson(Map<String, dynamic> json) {
    return TvDetails(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      createdBy:
          (json['created_by'] as List?)
              ?.map((i) => TvCreator.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      episodeRunTime:
          (json['episode_run_time'] as List?)?.map((e) => e as int).toList() ??
          [],
      firstAirDate: json['first_air_date'] as String? ?? '',
      genres:
          (json['genres'] as List?)
              ?.map((i) => Genre.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String? ?? '',
      id: json['id'] as int,
      inProduction: json['in_production'] as bool? ?? false,
      languages:
          (json['languages'] as List?)?.map((e) => e as String).toList() ?? [],
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? TvLastEpisodeToAir.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>,
            )
          : null,
      name: json['name'] as String,
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? TvLastEpisodeToAir.fromJson(
              json['next_episode_to_air'] as Map<String, dynamic>,
            )
          : null,
      networks:
          (json['networks'] as List?)
              ?.map((i) => NetworkDetails.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      numberOfEpisodes: json['number_of_episodes'] as int? ?? 0,
      numberOfSeasons: json['number_of_seasons'] as int? ?? 0,
      originCountry:
          (json['origin_country'] as List?)?.map((e) => e as String).toList() ??
          [],
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      productionCompanies:
          (json['production_companies'] as List?)
              ?.map(
                (i) => TvProductionCompany.fromJson(i as Map<String, dynamic>),
              )
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List?)
              ?.map(
                (i) => TvProductionCountry.fromJson(i as Map<String, dynamic>),
              )
              .toList() ??
          [],
      seasons:
          (json['seasons'] as List?)
              ?.map((i) => TvSeasonSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List?)
              ?.map((i) => TvSpokenLanguage.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      type: json['type'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}

class TvCreator {
  final int id;
  final String creditId;
  final String name;
  final int? gender;
  final String? profilePath;

  TvCreator({
    required this.id,
    required this.creditId,
    required this.name,
    this.gender,
    this.profilePath,
  });

  factory TvCreator.fromJson(Map<String, dynamic> json) {
    return TvCreator(
      id: json['id'] as int,
      creditId: json['credit_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as int?,
      profilePath: json['profile_path'] as String?,
    );
  }
}

class TvLastEpisodeToAir {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  TvLastEpisodeToAir({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory TvLastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    return TvLastEpisodeToAir(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      airDate: json['air_date'] as String? ?? '',
      episodeNumber: json['episode_number'] as int,
      episodeType: json['episode_type'] as String? ?? '',
      productionCode: json['production_code'] as String? ?? '',
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int,
      showId: json['show_id'] as int,
      stillPath: json['still_path'] as String?,
    );
  }
}

class TvSeasonSummary {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  TvSeasonSummary({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvSeasonSummary.fromJson(Map<String, dynamic> json) {
    return TvSeasonSummary(
      airDate: json['air_date'] as String?,
      episodeCount: json['episode_count'] as int? ?? 0,
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int? ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class TvProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  TvProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory TvProductionCompany.fromJson(Map<String, dynamic> json) {
    return TvProductionCompany(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String? ?? '',
    );
  }
}

class TvProductionCountry {
  final String iso_3166_1;
  final String name;

  TvProductionCountry({required this.iso_3166_1, required this.name});

  factory TvProductionCountry.fromJson(Map<String, dynamic> json) {
    return TvProductionCountry(
      iso_3166_1: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );
  }
}

class TvSpokenLanguage {
  final String englishName;
  final String iso_639_1;
  final String name;

  TvSpokenLanguage({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });

  factory TvSpokenLanguage.fromJson(Map<String, dynamic> json) {
    return TvSpokenLanguage(
      englishName: json['english_name'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
    );
  }
}
