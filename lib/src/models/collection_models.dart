import 'media_models.dart';

/// [CollectionDetails] represents the full information about a movie collection.
class CollectionDetails {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final List<MovieSummary> parts;

  CollectionDetails({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.parts,
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

/// [CollectionTranslation] represents the translated metadata for a collection.
class CollectionTranslation {
  final String iso_3166_1;
  final String iso_639_1;
  final String name;
  final String englishName;
  final TranslationData data;

  CollectionTranslation({
    required this.iso_3166_1,
    required this.iso_639_1,
    required this.name,
    required this.englishName,
    required this.data,
  });

  factory CollectionTranslation.fromJson(Map<String, dynamic> json) {
    return CollectionTranslation(
      iso_3166_1: json['iso_3166_1'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
      englishName: json['english_name'] as String,
      data: TranslationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

/// [TranslationData] contains the actual translated fields.
class TranslationData {
  final String name;
  final String overview;
  final String homepage;

  TranslationData({
    required this.name,
    required this.overview,
    required this.homepage,
  });

  factory TranslationData.fromJson(Map<String, dynamic> json) {
    return TranslationData(
      name: json['title'] as String? ?? json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      homepage: json['homepage'] as String? ?? '',
    );
  }
}

/// [CollectionTranslationsResponse] contains a list of translations for a collection.
class CollectionTranslationsResponse {
  final int id;
  final List<CollectionTranslation> translations;

  CollectionTranslationsResponse({
    required this.id,
    required this.translations,
  });

  factory CollectionTranslationsResponse.fromJson(Map<String, dynamic> json) {
    return CollectionTranslationsResponse(
      id: json['id'] as int,
      translations: (json['translations'] as List)
          .map((item) => CollectionTranslation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
