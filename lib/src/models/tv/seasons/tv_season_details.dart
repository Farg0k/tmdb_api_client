/// [TvSeasonDetails] represents the full information about a TV season.
class TvSeasonDetails {
  final String? airDate;
  final List<TvEpisodeSummary> episodes;
  final String name;
  final String overview;
  final int id;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  TvSeasonDetails({
    this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvSeasonDetails.fromJson(Map<String, dynamic> json) {
    return TvSeasonDetails(
      airDate: json['air_date'] as String?,
      episodes: (json['episodes'] as List?)
              ?.map((i) => TvEpisodeSummary.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      id: json['id'] as int,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int? ?? 0,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// [TvEpisodeSummary] represents a concise version of TV episode data.
class TvEpisodeSummary {
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  final List<TvEpisodeCrew>? crew;
  final List<TvEpisodeGuestStar>? guestStars;

  TvEpisodeSummary({
    this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    this.crew,
    this.guestStars,
  });

  factory TvEpisodeSummary.fromJson(Map<String, dynamic> json) {
    return TvEpisodeSummary(
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int? ?? 0,
      episodeType: json['episode_type'] as String? ?? '',
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      productionCode: json['production_code'] as String? ?? '',
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int? ?? 0,
      showId: json['show_id'] as int? ?? 0,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      crew: (json['crew'] as List?)
          ?.map((i) => TvEpisodeCrew.fromJson(i as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List?)
          ?.map((i) => TvEpisodeGuestStar.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TvEpisodeCrew {
  final String department;
  final String job;
  final String creditId;
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;

  TvEpisodeCrew({
    required this.department,
    required this.job,
    required this.creditId,
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
  });

  factory TvEpisodeCrew.fromJson(Map<String, dynamic> json) {
    return TvEpisodeCrew(
      department: json['department'] as String? ?? '',
      job: json['job'] as String? ?? '',
      creditId: json['credit_id'] as String? ?? '',
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
    );
  }
}

class TvEpisodeGuestStar {
  final String character;
  final String creditId;
  final int order;
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;

  TvEpisodeGuestStar({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
  });

  factory TvEpisodeGuestStar.fromJson(Map<String, dynamic> json) {
    return TvEpisodeGuestStar(
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
    );
  }
}
