/// [PersonDetails] represents the full information about a person.
class PersonDetails {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final String? birthday;
  final String? deathday;
  final int gender;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String knownForDepartment;
  final String name;
  final String placeOfBirth;
  final double popularity;
  final String? profilePath;

  PersonDetails({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    this.birthday,
    this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    this.profilePath,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) {
    return PersonDetails(
      adult: json['adult'] as bool,
      alsoKnownAs:
          (json['also_known_as'] as List?)?.map((e) => e as String).toList() ??
          [],
      biography: json['biography'] as String? ?? '',
      birthday: json['birthday'] as String?,
      deathday: json['deathday'] as String?,
      gender: json['gender'] as int? ?? 0,
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      placeOfBirth: json['place_of_birth'] as String? ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
    );
  }
}
