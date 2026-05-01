/// [TvAggregateCredits] contains cast and crew for a TV series with aggregate role info.
class TvAggregateCredits {
  final int id;
  final List<TvAggregateCast> cast;
  final List<TvAggregateCrew> crew;

  TvAggregateCredits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory TvAggregateCredits.fromJson(Map<String, dynamic> json) {
    return TvAggregateCredits(
      id: json['id'] as int,
      cast: (json['cast'] as List)
          .map((i) => TvAggregateCast.fromJson(i as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List)
          .map((i) => TvAggregateCrew.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TvAggregateCast {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<TvCastRole> roles;
  final int totalEpisodeCount;
  final String order;

  TvAggregateCast({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.roles,
    required this.totalEpisodeCount,
    required this.order,
  });

  factory TvAggregateCast.fromJson(Map<String, dynamic> json) {
    return TvAggregateCast(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      roles: (json['roles'] as List)
          .map((i) => TvCastRole.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalEpisodeCount: json['total_episode_count'] as int? ?? 0,
      order: json['order'].toString(),
    );
  }
}

class TvCastRole {
  final String creditId;
  final String character;
  final int episodeCount;

  TvCastRole({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  factory TvCastRole.fromJson(Map<String, dynamic> json) {
    return TvCastRole(
      creditId: json['credit_id'] as String,
      character: json['character'] as String? ?? '',
      episodeCount: json['episode_count'] as int? ?? 0,
    );
  }
}

class TvAggregateCrew {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<TvCrewJob> jobs;
  final int totalEpisodeCount;
  final String department;

  TvAggregateCrew({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.jobs,
    required this.totalEpisodeCount,
    required this.department,
  });

  factory TvAggregateCrew.fromJson(Map<String, dynamic> json) {
    return TvAggregateCrew(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      jobs: (json['jobs'] as List)
          .map((i) => TvCrewJob.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalEpisodeCount: json['total_episode_count'] as int? ?? 0,
      department: json['department'] as String? ?? '',
    );
  }
}

class TvCrewJob {
  final String creditId;
  final String job;
  final int episodeCount;

  TvCrewJob({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  factory TvCrewJob.fromJson(Map<String, dynamic> json) {
    return TvCrewJob(
      creditId: json['credit_id'] as String,
      job: json['job'] as String? ?? '',
      episodeCount: json['episode_count'] as int? ?? 0,
    );
  }
}
