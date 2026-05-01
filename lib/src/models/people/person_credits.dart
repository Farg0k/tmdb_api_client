/// [PersonCredits] contains common structures for Movie and TV credits for a person.
class PersonCredits {
  final int id;
  final List<PersonCastCredit> cast;
  final List<PersonCrewCredit> crew;

  PersonCredits({required this.id, required this.cast, required this.crew});

  factory PersonCredits.fromJson(Map<String, dynamic> json) {
    return PersonCredits(
      id: json['id'] as int,
      cast: (json['cast'] as List).map((i) => PersonCastCredit.fromJson(i as Map<String, dynamic>)).toList(),
      crew: (json['crew'] as List).map((i) => PersonCrewCredit.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }
}

class PersonCastCredit {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String? originalTitle;
  final String? originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? title;
  final String? name;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final String character;
  final String creditId;
  final int? order;
  final String? mediaType;

  PersonCastCredit({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    this.originalTitle,
    this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    this.title,
    this.name,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.character,
    required this.creditId,
    this.order,
    this.mediaType,
  });

  factory PersonCastCredit.fromJson(Map<String, dynamic> json) {
    return PersonCastCredit(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List?)?.map((e) => e as int).toList() ?? [],
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String,
      order: json['order'] as int?,
      mediaType: json['media_type'] as String?,
    );
  }
}

class PersonCrewCredit {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String? originalTitle;
  final String? originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? title;
  final String? name;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final String creditId;
  final String department;
  final String job;
  final String? mediaType;

  PersonCrewCredit({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    this.originalTitle,
    this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    this.title,
    this.name,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.creditId,
    required this.department,
    required this.job,
    this.mediaType,
  });

  factory PersonCrewCredit.fromJson(Map<String, dynamic> json) {
    return PersonCrewCredit(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List?)?.map((e) => e as int).toList() ?? [],
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      creditId: json['credit_id'] as String,
      department: json['department'] as String? ?? '',
      job: json['job'] as String? ?? '',
      mediaType: json['media_type'] as String?,
    );
  }
}
