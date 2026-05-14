import 'media_models.dart';

/// [TmdbListDetails] represents the full information about a v3 list.
class TmdbListDetails {
  final String createdBy;
  final String description;
  final int favoriteCount;
  final String id;
  final List<MovieSummary> items;
  final int itemCount;
  final String iso_639_1;
  final String name;
  final String? posterPath;

  // Appended resources (optional)
  final List<Map<String, dynamic>>? comments;
  final List<Map<String, dynamic>>? votes;

  TmdbListDetails({
    required this.createdBy,
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.items,
    required this.itemCount,
    required this.iso_639_1,
    required this.name,
    this.posterPath,
    this.comments,
    this.votes,
  });

  factory TmdbListDetails.fromJson(Map<String, dynamic> json) {
    return TmdbListDetails(
      createdBy: json['created_by'] as String,
      description: json['description'] as String? ?? '',
      favoriteCount: json['favorite_count'] as int? ?? 0,
      id: json['id'].toString(),
      items: (json['items'] as List)
          .map((item) => MovieSummary.fromJson(item as Map<String, dynamic>))
          .toList(),
      itemCount: json['item_count'] as int,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
      posterPath: json['poster_path'] as String?,
      // Appended resources
      comments: (json['comments'] as List?)?.cast<Map<String, dynamic>>(),
      votes: (json['votes'] as List?)?.cast<Map<String, dynamic>>(),
    );
  }
}

/// [TmdbListCreateResponse] represents the response when creating a new list.
class TmdbListCreateResponse {
  final bool success;
  final String statusMessage;
  final int statusCode;
  final int listId;

  TmdbListCreateResponse({
    required this.success,
    required this.statusMessage,
    required this.statusCode,
    required this.listId,
  });

  factory TmdbListCreateResponse.fromJson(Map<String, dynamic> json) {
    return TmdbListCreateResponse(
      success: json['success'] as bool,
      statusMessage: json['status_message'] as String,
      statusCode: json['status_code'] as int,
      listId: json['list_id'] as int,
    );
  }
}

/// [TmdbListOperationResponse] represents a generic response for list operations.
class TmdbListOperationResponse {
  final bool success;
  final String statusMessage;
  final int statusCode;

  TmdbListOperationResponse({
    required this.success,
    required this.statusMessage,
    required this.statusCode,
  });

  factory TmdbListOperationResponse.fromJson(Map<String, dynamic> json) {
    return TmdbListOperationResponse(
      success: json['success'] as bool? ?? false,
      statusMessage: json['status_message'] as String? ?? '',
      statusCode: json['status_code'] as int? ?? 0,
    );
  }
}
