/// [TmdbReview] represents a user review for a movie or TV show.
class TmdbReview {
  final String author;
  final TmdbReviewAuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;

  TmdbReview({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory TmdbReview.fromJson(Map<String, dynamic> json) {
    return TmdbReview(
      author: json['author'] as String? ?? '',
      authorDetails: TmdbReviewAuthorDetails.fromJson(json['author_details'] as Map<String, dynamic>),
      content: json['content'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      id: json['id'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}

class TmdbReviewAuthorDetails {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  TmdbReviewAuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory TmdbReviewAuthorDetails.fromJson(Map<String, dynamic> json) {
    return TmdbReviewAuthorDetails(
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      avatarPath: json['avatar_path'] as String?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
    );
  }
}
