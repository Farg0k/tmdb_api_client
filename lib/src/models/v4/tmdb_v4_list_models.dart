import '../media_models.dart';

/// [TmdbListV4Details] represents the full information about a v4 list.
class TmdbListV4Details {
  final String? backdropPath;
  final int id;
  final int page;
  final List<TmdbListV4Item> results;
  final int totalPages;
  final int totalResults;
  final String name;
  final String description;
  final String iso_639_1;
  final String? posterPath;
  final bool public;
  final double revenue;
  final int runtime;
  final String sortBy;

  TmdbListV4Details({
    this.backdropPath,
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
    required this.name,
    required this.description,
    required this.iso_639_1,
    this.posterPath,
    required this.public,
    required this.revenue,
    required this.runtime,
    required this.sortBy,
  });

  factory TmdbListV4Details.fromJson(Map<String, dynamic> json) {
    return TmdbListV4Details(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      page: json['page'] as int,
      results: (json['results'] as List)
          .map((i) => TmdbListV4Item.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iso_639_1: json['iso_639_1'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      public: json['public'] as bool? ?? false,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] as int? ?? 0,
      sortBy: json['sort_by'] as String? ?? '',
    );
  }
}

/// [TmdbListV4Item] represents a single item in a v4 list with optional comment.
class TmdbListV4Item {
  final dynamic media; // MovieSummary or TvSummary
  final String mediaType;
  final String? comment;

  TmdbListV4Item({
    required this.media,
    required this.mediaType,
    this.comment,
  });

  factory TmdbListV4Item.fromJson(Map<String, dynamic> json) {
    final type = json['media_type'] as String;
    dynamic media;
    if (type == 'movie') {
      media = MovieSummary.fromJson(json);
    } else if (type == 'tv') {
      media = TvSummary.fromJson(json);
    } else {
      media = json;
    }

    return TmdbListV4Item(
      media: media,
      mediaType: type,
      comment: json['comment'] as String?,
    );
  }
}

/// [TmdbListV4CreateResponse] represents the response when creating a new v4 list.
class TmdbListV4CreateResponse {
  final bool success;
  final int id;
  final int statusCode;
  final String statusMessage;

  TmdbListV4CreateResponse({
    required this.success,
    required this.id,
    required this.statusCode,
    required this.statusMessage,
  });

  factory TmdbListV4CreateResponse.fromJson(Map<String, dynamic> json) {
    return TmdbListV4CreateResponse(
      success: json['success'] as bool,
      id: json['id'] as int,
      statusCode: json['status_code'] as int,
      statusMessage: json['status_message'] as String,
    );
  }
}

/// [TmdbListV4OperationResponse] represents a generic response for v4 list operations.
class TmdbListV4OperationResponse {
  final bool success;
  final int statusCode;
  final String statusMessage;
  final List<TmdbListV4ItemStatus>? results;

  TmdbListV4OperationResponse({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
    this.results,
  });

  factory TmdbListV4OperationResponse.fromJson(Map<String, dynamic> json) {
    return TmdbListV4OperationResponse(
      success: json['success'] as bool? ?? false,
      statusCode: json['status_code'] as int? ?? 0,
      statusMessage: json['status_message'] as String? ?? '',
      results: (json['results'] as List?)
          ?.map((i) => TmdbListV4ItemStatus.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TmdbListV4ItemStatus {
  final int mediaId;
  final String mediaType;
  final bool success;
  final String? comment;

  TmdbListV4ItemStatus({
    required this.mediaId,
    required this.mediaType,
    required this.success,
    this.comment,
  });

  factory TmdbListV4ItemStatus.fromJson(Map<String, dynamic> json) {
    return TmdbListV4ItemStatus(
      mediaId: json['media_id'] as int,
      mediaType: json['media_type'] as String,
      success: json['success'] as bool,
      comment: json['comment'] as String?,
    );
  }
}

/// [TmdbAccountV4ListsResponse] represents the response for user's v4 lists.
class TmdbAccountV4ListsResponse {
  final int page;
  final List<TmdbListV4Summary> results;
  final int totalPages;
  final int totalResults;

  TmdbAccountV4ListsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbAccountV4ListsResponse.fromJson(Map<String, dynamic> json) {
    return TmdbAccountV4ListsResponse(
      page: json['page'] as int,
      results: (json['results'] as List)
          .map((i) => TmdbListV4Summary.fromJson(i as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}

class TmdbListV4Summary {
  final String? backdropPath;
  final String description;
  final int id;
  final String iso_639_1;
  final int itemCount;
  final String name;
  final String? posterPath;
  final bool public;
  final double revenue;
  final int runtime;
  final String sortBy;

  TmdbListV4Summary({
    this.backdropPath,
    required this.description,
    required this.id,
    required this.iso_639_1,
    required this.itemCount,
    required this.name,
    this.posterPath,
    required this.public,
    required this.revenue,
    required this.runtime,
    required this.sortBy,
  });

  factory TmdbListV4Summary.fromJson(Map<String, dynamic> json) {
    return TmdbListV4Summary(
      backdropPath: json['backdrop_path'] as String?,
      description: json['description'] as String? ?? '',
      id: json['id'] as int,
      iso_639_1: json['iso_639_1'] as String? ?? '',
      itemCount: json['item_count'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      public: json['public'] as bool? ?? false,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] as int? ?? 0,
      sortBy: json['sort_by'] as String? ?? '',
    );
  }
}
