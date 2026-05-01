/// [TmdbImage] represents a single image related to a movie, TV show, or person.
class TmdbImage {
  final double aspectRatio;
  final int height;
  final String? iso_639_1;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  TmdbImage({
    required this.aspectRatio,
    required this.height,
    this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory TmdbImage.fromJson(Map<String, dynamic> json) {
    return TmdbImage(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 0.0,
      height: json['height'] as int? ?? 0,
      iso_639_1: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      width: json['width'] as int? ?? 0,
    );
  }
}

class TmdbImagesResponse {
  final int id;
  final List<TmdbImage> backdrops;
  final List<TmdbImage> logos;
  final List<TmdbImage> posters;
  final List<TmdbImage>? profiles;

  TmdbImagesResponse({
    required this.id,
    required this.backdrops,
    required this.logos,
    required this.posters,
    this.profiles,
  });

  factory TmdbImagesResponse.fromJson(Map<String, dynamic> json) {
    return TmdbImagesResponse(
      id: json['id'] as int? ?? 0,
      backdrops:
          (json['backdrops'] as List?)
              ?.map((i) => TmdbImage.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      logos:
          (json['logos'] as List?)
              ?.map((i) => TmdbImage.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      posters:
          (json['posters'] as List?)
              ?.map((i) => TmdbImage.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      profiles: (json['profiles'] as List?)
          ?.map((i) => TmdbImage.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
