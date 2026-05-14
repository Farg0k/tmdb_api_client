/// [TmdbCast] represents a unified cast member for Movies, TV, and Episodes.
class TmdbCast {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? character;
  final String creditId;
  final int? order;
  final int? castId; // Specific to Movies

  TmdbCast({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.character,
    required this.creditId,
    this.order,
    this.castId,
  });

  factory TmdbCast.fromJson(Map<String, dynamic> json) {
    return TmdbCast(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      character: json['character'] as String?,
      creditId: json['credit_id'] as String? ?? '',
      order: json['order'] as int?,
      castId: json['cast_id'] as int?,
    );
  }

  @override
  String toString() {
    return '''TmdbCast{
      adult: $adult, 
      gender: $gender, 
      id: $id, 
      knownForDepartment: $knownForDepartment, 
      name: $name, 
      originalName: $originalName, 
      popularity: $popularity, 
      profilePath: $profilePath, 
      character: $character, 
      creditId: $creditId, 
      order: $order, 
      castId: $castId
    }''';
  }
}

/// [TmdbCrew] represents a unified crew member for Movies, TV, and Episodes.
class TmdbCrew {
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

  TmdbCrew({
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

  factory TmdbCrew.fromJson(Map<String, dynamic> json) {
    return TmdbCrew(
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String? ?? '',
      department: json['department'] as String? ?? '',
      job: json['job'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return '''TmdbCrew{
      adult: $adult, 
      gender: $gender, 
      id: $id, 
      knownForDepartment: $knownForDepartment, 
      name: $name, 
      originalName: $originalName, 
      popularity: $popularity, 
      profilePath: $profilePath, 
      creditId: $creditId, 
      department: $department, 
      job: $job
    }''';
  }
}

/// [TmdbCredits] represents a generic credits response.
class TmdbCredits {
  final int id;
  final List<TmdbCast> cast;
  final List<TmdbCrew> crew;
  final List<TmdbCast>? guestStars; // Specific to Episodes

  TmdbCredits({
    required this.id,
    required this.cast,
    required this.crew,
    this.guestStars,
  });

  factory TmdbCredits.fromJson(Map<String, dynamic> json) {
    return TmdbCredits(
      id: json['id'] as int? ?? 0,
      cast:
          (json['cast'] as List?)
              ?.map((i) => TmdbCast.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      crew:
          (json['crew'] as List?)
              ?.map((i) => TmdbCrew.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      guestStars: (json['guest_stars'] as List?)
          ?.map((i) => TmdbCast.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return '''TmdbCredits{
      id: $id, 
      cast: $cast, 
      crew: $crew, 
      guestStars: $guestStars
    }''';
  }
}
