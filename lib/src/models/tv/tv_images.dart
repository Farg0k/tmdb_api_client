import '../movies/movie_images.dart';

class TvImagesResponse {
  final int id;
  final List<MovieImage> backdrops;
  final List<MovieImage> logos;
  final List<MovieImage> posters;

  TvImagesResponse({
    required this.id,
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  factory TvImagesResponse.fromJson(Map<String, dynamic> json) {
    return TvImagesResponse(
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
