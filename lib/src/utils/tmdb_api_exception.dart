
/// [TmdbApiException] is a custom exception for errors originating from the TMDB API itself.
/// It includes the error message, HTTP status code, and an optional TMDB-specific error code.
class TmdbApiException implements Exception {
  final String message; // A human-readable error message.
  final int statusCode; // The HTTP status code returned by the API (e.g., 401, 404).
  final int? errorCode; // An optional TMDB-specific error code.

  TmdbApiException(this.message, {required this.statusCode, this.errorCode});

  @override
  String toString() => 'TmdbApiException: $message (Status: $statusCode, Code: ${errorCode ?? 'N/A'})';
}

/// [TmdbNetworkException] is a custom exception for network-related errors
/// that occur during the HTTP request (e.g., no internet connection).
class TmdbNetworkException implements Exception {
  final String message; // A human-readable error message describing the network issue.

  TmdbNetworkException(this.message);

  @override
  String toString() => 'TmdbNetworkException: $message';
}