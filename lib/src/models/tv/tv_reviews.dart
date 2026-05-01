import '../movies/movie_reviews.dart';

class TvReviewsResponse {
  final int id;
  final int page;
  final List<MovieReview> results;
  final int totalPages;
  final int totalResults;

  TvReviewsResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvReviewsResponse.fromJson(Map<String, dynamic> json) {
    return TvReviewsResponse(
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List)
          .map((i) => MovieReview.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
