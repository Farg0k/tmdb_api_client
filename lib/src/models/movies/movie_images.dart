/// [MovieImage] represents a single image related to a movie.
class MovieImage {
  final double aspectRatio;
  final int height;
  final String? iso_639_1;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  MovieImage({
    required this.aspectRatio,
    required this.height,
    this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    return MovieImage(
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      height: json['height'] as int,
      iso_639_1: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );
  }
}

class MovieImagesResponse {
  final int id;
  final List<MovieImage> backdrops;
  final List<MovieImage> logos;
  final List<MovieImage> posters;

  MovieImagesResponse({
    required this.id,
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  factory MovieImagesResponse.fromJson(Map<String, dynamic> json) {
    return MovieImagesResponse(
      id: json['id'] as int,
      backdrops: (json['backdrops'] as List)
          .map((i) => MovieImage.fromJson(i as Map<String, dynamic>))
          .toList(),
      logos: (json['logos'] as List)
          .map((i) => MovieImage.fromJson(i as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List)
          .map((i) => MovieImage.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
