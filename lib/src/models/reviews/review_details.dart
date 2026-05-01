import '../common/tmdb_review.dart';

/// [ReviewDetails] represents the full information about a specific review.
class ReviewDetails {
  final String author;
  final TmdbReviewAuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String iso_639_1;
  final int mediaId;
  final String mediaTitle;
  final String mediaType;
  final String updatedAt;
  final String url;

  ReviewDetails({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.iso_639_1,
    required this.mediaId,
    required this.mediaTitle,
    required this.mediaType,
    required this.updatedAt,
    required this.url,
  });

  factory ReviewDetails.fromJson(Map<String, dynamic> json) {
    return ReviewDetails(
      author: json['author'] as String? ?? '',
      authorDetails: TmdbReviewAuthorDetails.fromJson(
        json['author_details'] as Map<String, dynamic>,
      ),
      content: json['content'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      id: json['id'] as String? ?? '',
      iso_639_1: json['iso_639_1'] as String? ?? '',
      mediaId: json['media_id'] as int? ?? 0,
      mediaTitle: json['media_title'] as String? ?? '',
      mediaType: json['media_type'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}
