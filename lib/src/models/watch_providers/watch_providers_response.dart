import '../movies/movie_watch_providers.dart';

/// [WatchProvidersResponse] contains a list of available watch providers.
class WatchProvidersResponse {
  final List<WatchProvider> results;

  WatchProvidersResponse({required this.results});

  factory WatchProvidersResponse.fromJson(Map<String, dynamic> json) {
    return WatchProvidersResponse(
      results: (json['results'] as List)
          .map((i) => WatchProvider.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
