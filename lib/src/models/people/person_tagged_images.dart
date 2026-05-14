import '../common/tmdb_image.dart';
import '../media_models.dart';

/// [PersonTaggedImage] represents an image of a person that is tagged with media info.
class PersonTaggedImage extends TmdbImage {
  final String id;
  final String imageType;
  final MediaSummary? media; // Can be MovieSummary or TvSummary data
  final String mediaType;

  PersonTaggedImage({
    required super.aspectRatio,
    required super.height,
    super.iso_639_1,
    required super.filePath,
    required super.voteAverage,
    required super.voteCount,
    required super.width,
    required this.id,
    required this.imageType,
    required this.media,
    required this.mediaType,
  });

  factory PersonTaggedImage.fromJson(Map<String, dynamic> json) {
    final mediaData = json['media'] as Map<String, dynamic>?;
    final type = json['media_type'] as String?;
    MediaSummary? media;

    if (mediaData != null) {
      if (type == 'movie' || mediaData.containsKey('title')) {
        media = MovieSummary.fromJson(mediaData);
      } else if (type == 'tv' || mediaData.containsKey('name')) {
        media = TvSummary.fromJson(mediaData);
      }
    }

    return PersonTaggedImage(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 0.0,
      height: json['height'] as int? ?? 0,
      iso_639_1: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      width: json['width'] as int? ?? 0,
      id: json['id'] as String? ?? '',
      imageType: json['image_type'] as String? ?? '',
      media: media,
      mediaType: type ?? '',
    );
  }
}

class PersonTaggedImagesResponse {
  final int id;
  final int page;
  final List<PersonTaggedImage> results;
  final int totalPages;
  final int totalResults;

  PersonTaggedImagesResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PersonTaggedImagesResponse.fromJson(Map<String, dynamic> json) {
    return PersonTaggedImagesResponse(
      id: json['id'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      results:
          (json['results'] as List?)
              ?.map(
                (i) => PersonTaggedImage.fromJson(i as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPages: json['total_pages'] as int? ?? 0,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }
}
