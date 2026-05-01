import '../movies/movie_watch_providers.dart';

class TvWatchProvidersResponse {
  final int id;
  final Map<String, CountryWatchProviders> results;

  TvWatchProvidersResponse({required this.id, required this.results});

  factory TvWatchProvidersResponse.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'] as Map<String, dynamic>;
    final mappedResults = <String, CountryWatchProviders>{};

    rawResults.forEach((country, data) {
      mappedResults[country] = CountryWatchProviders.fromJson(data as Map<String, dynamic>);
    });

    return TvWatchProvidersResponse(id: json['id'] as int, results: mappedResults);
  }
}
