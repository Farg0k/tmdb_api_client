/// [TmdbListResponse] is a generic wrapper for non-paginated lists that have an ID.
/// Used for Videos, Images, Keywords, etc.
class TmdbListResponse<T> {
  final int id;
  final List<T> results;

  TmdbListResponse({required this.id, required this.results});

  factory TmdbListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT, {
    String resultsKey = 'results',
  }) {
    return TmdbListResponse<T>(
      id: json['id'] as int? ?? 0,
      results:
          (json[resultsKey] as List?)
              ?.map((i) => fromJsonT(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
