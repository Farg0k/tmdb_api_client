import '../movies/movie_videos.dart';

class TvVideosResponse {
  final int id;
  final List<MovieVideo> results;

  TvVideosResponse({required this.id, required this.results});

  factory TvVideosResponse.fromJson(Map<String, dynamic> json) {
    return TvVideosResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => MovieVideo.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
