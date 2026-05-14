import 'media_models.dart';
import 'common/tmdb_translation.dart';

/// [CollectionDetails] represents the full information about a movie collection.
class CollectionDetails {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final List<MovieSummary> parts;

  // Appended resources (optional)
  final CollectionImagesResponse? images;
  final TmdbTranslationsResponse? translations;

  CollectionDetails({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.parts,
    this.images,
    this.translations,
  });

  factory CollectionDetails.fromJson(Map<String, dynamic> json) {
    return CollectionDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      parts: (json['parts'] as List)
          .map((item) => MovieSummary.fromJson(item as Map<String, dynamic>))
          .toList(),
      // Appended resources
      images: json['images'] != null
          ? CollectionImagesResponse.fromJson(
              json['images'] as Map<String, dynamic>,
            )
          : null,
      translations: json['translations'] != null
          ? TmdbTranslationsResponse.fromJson(
              json['translations'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// [CollectionImage] represents a single image (poster or backdrop) in a collection.
class CollectionImage {
  final double aspectRatio;
  final int height;
  final int width;
  final String filePath;
  final double voteAverage;
  final int voteCount;

  CollectionImage({
    required this.aspectRatio,
    required this.height,
    required this.width,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory CollectionImage.fromJson(Map<String, dynamic> json) {
    return CollectionImage(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      width: json['width'] as int,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
  }
}

/// [CollectionImagesResponse] contains lists of posters and backdrops for a collection.
class CollectionImagesResponse {
  final int id;
  final List<CollectionImage> backdrops;
  final List<CollectionImage> posters;

  CollectionImagesResponse({
    required this.id,
    required this.backdrops,
    required this.posters,
  });

  factory CollectionImagesResponse.fromJson(Map<String, dynamic> json) {
    return CollectionImagesResponse(
      id: json['id'] as int,
      backdrops: (json['backdrops'] as List)
          .map((item) => CollectionImage.fromJson(item as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List)
          .map((item) => CollectionImage.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
