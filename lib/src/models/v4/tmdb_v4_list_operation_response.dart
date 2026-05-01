import 'tmdb_v4_list_item_status.dart';

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
