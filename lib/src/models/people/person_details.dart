import '../common/tmdb_credit.dart';
import '../common/tmdb_image.dart';
import '../common/tmdb_external_ids.dart';
import '../people/person_tagged_images.dart';
import 'combined_credits.dart';

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

  // Appended resources (optional)
  final CombinedCredits? combinedCredits;
  final TmdbCredits? movieCredits;
  final TmdbCredits? tvCredits;
  final TmdbImagesResponse? images;
  final Map<String, dynamic>? changes;
  final Map<String, dynamic>? translations;
  final TmdbExternalIds? externalIds;
  final PersonTaggedImagesResponse? taggedImages;

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
    this.combinedCredits,
    this.movieCredits,
    this.tvCredits,
    this.images,
    this.changes,
    this.translations,
    this.externalIds,
    this.taggedImages,
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
      // Appended resources
      combinedCredits: json['credits'] != null
          ? CombinedCredits.fromJson(
              json['credits'] as Map<String, dynamic>,
            )
          : null,
      movieCredits: json['movie_credits'] != null
          ? TmdbCredits.fromJson(
              json['movie_credits'] as Map<String, dynamic>,
            )
          : null,
      tvCredits: json['tv_credits'] != null
          ? TmdbCredits.fromJson(
              json['tv_credits'] as Map<String, dynamic>,
            )
          : null,
      images: json['images'] != null
          ? TmdbImagesResponse.fromJson(
              json['images'] as Map<String, dynamic>,
            )
          : null,
      changes: json['changes'] as Map<String, dynamic>?,
      translations: json['translations'] as Map<String, dynamic>?,
      externalIds: json['external_ids'] != null
          ? TmdbExternalIds.fromJson(
              json['external_ids'] as Map<String, dynamic>,
            )
          : null,
      taggedImages: json['tagged_images'] != null
          ? PersonTaggedImagesResponse.fromJson(
              json['tagged_images'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
