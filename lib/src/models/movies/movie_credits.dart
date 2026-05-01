/// [MovieCredits] contains cast and crew for a movie.
class MovieCredits {
  final int id;
  final List<MovieCast> cast;
  final List<MovieCrew> crew;

  MovieCredits({required this.id, required this.cast, required this.crew});

  factory MovieCredits.fromJson(Map<String, dynamic> json) {
    return MovieCredits(
      id: json['id'] as int,
      cast: (json['cast'] as List).map((i) => MovieCast.fromJson(i as Map<String, dynamic>)).toList(),
      crew: (json['crew'] as List).map((i) => MovieCrew.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }
}

class MovieCast {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int order;

  MovieCast({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    required this.order,
  });

  factory MovieCast.fromJson(Map<String, dynamic> json) {
    return MovieCast(
      adult: json['adult'] as bool,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      castId: json['cast_id'] as int?,
      character: json['character'] as String?,
      creditId: json['credit_id'] as String,
      order: json['order'] as int? ?? 0,
    );
  }
}

class MovieCrew {
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

  MovieCrew({
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

  factory MovieCrew.fromJson(Map<String, dynamic> json) {
    return MovieCrew(
      adult: json['adult'] as bool,
      gender: json['gender'] as int?,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      department: json['department'] as String,
      job: json['job'] as String,
    );
  }
}
