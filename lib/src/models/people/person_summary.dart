/// [PersonSummary] represents a concise version of person data returned in lists.
class PersonSummary {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String? profilePath;
  final List<dynamic> knownFor; // Can contain MovieSummary or TvSummary data

  PersonSummary({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    this.profilePath,
    required this.knownFor,
  });

  factory PersonSummary.fromJson(Map<String, dynamic> json) {
    return PersonSummary(
      adult: json['adult'] as bool,
      gender: json['gender'] as int? ?? 0,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      knownFor: json['known_for'] as List? ?? [],
    );
  }
}
