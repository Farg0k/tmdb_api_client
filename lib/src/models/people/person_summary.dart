import '../media_models.dart';

/// [PersonSummary] represents a concise version of person data returned in lists.
class PersonSummary {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String? profilePath;
  final List<MediaSummary>
  knownFor; // Can contain MovieSummary or TvSummary data

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
      adult: json['adult'] as bool? ?? false,
      gender: json['gender'] as int? ?? 0,
      id: json['id'] as int,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      knownFor:
          (json['known_for'] as List?)?.map((i) {
            final map = i as Map<String, dynamic>;
            final mediaType = map['media_type'] as String?;
            if (mediaType == 'movie') {
              return MovieSummary.fromJson(map);
            } else if (mediaType == 'tv') {
              return TvSummary.fromJson(map);
            }
            // Fallback for cases where media_type might be missing but fields are present
            return map.containsKey('title')
                ? MovieSummary.fromJson(map)
                : TvSummary.fromJson(map);
          }).toList() ??
          [],
    );
  }
}
