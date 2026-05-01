import 'person_images.dart';

/// [PersonTaggedImage] represents an image of a person that is tagged with media info.
class PersonTaggedImage extends PersonImage {
  final String id;
  final String imageType;
  final dynamic media; // Can be MovieSummary or TvSummary data
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
    return PersonTaggedImage(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso_639_1: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
      id: json['id'] as String,
      imageType: json['image_type'] as String,
      media: json['media'],
      mediaType: json['media_type'] as String,
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
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List)
          .map((i) => PersonTaggedImage.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
