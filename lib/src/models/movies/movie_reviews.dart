/// [MovieReview] represents a user review for a movie.
class MovieReview {
  final String author;
  final MovieReviewAuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;

  MovieReview({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory MovieReview.fromJson(Map<String, dynamic> json) {
    return MovieReview(
      author: json['author'] as String,
      authorDetails: MovieReviewAuthorDetails.fromJson(json['author_details'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      id: json['id'] as String,
      updatedAt: json['updated_at'] as String,
      url: json['url'] as String,
    );
  }
}

class MovieReviewAuthorDetails {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  MovieReviewAuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory MovieReviewAuthorDetails.fromJson(Map<String, dynamic> json) {
    return MovieReviewAuthorDetails(
      name: json['name'] as String? ?? '',
      username: json['username'] as String,
      avatarPath: json['avatar_path'] as String?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
    );
  }
}

class MovieReviewsResponse {
  final int id;
  final int page;
  final List<MovieReview> results;
  final int totalPages;
  final int totalResults;

  MovieReviewsResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieReviewsResponse.fromJson(Map<String, dynamic> json) {
    return MovieReviewsResponse(
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List).map((i) => MovieReview.fromJson(i as Map<String, dynamic>)).toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
