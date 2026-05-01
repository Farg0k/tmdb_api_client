class TvCredits {
  final int id;
  final List<TvCast> cast;
  final List<TvCrew> crew;

  TvCredits({required this.id, required this.cast, required this.crew});

  factory TvCredits.fromJson(Map<String, dynamic> json) {
    return TvCredits(
      id: json['id'] as int,
      cast: (json['cast'] as List).map((i) => TvCast.fromJson(i as Map<String, dynamic>)).toList(),
      crew: (json['crew'] as List).map((i) => TvCrew.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }
}

class TvCast {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String character;
  final String creditId;
  final int order;

  TvCast({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory TvCast.fromJson(Map<String, dynamic> json) {
    return TvCast(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String,
      order: json['order'] as int? ?? 0,
    );
  }
}

class TvCrew {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;

  TvCrew({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory TvCrew.fromJson(Map<String, dynamic> json) {
    return TvCrew(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      department: json['department'] as String? ?? '',
      job: json['job'] as String? ?? '',
    );
  }
}
