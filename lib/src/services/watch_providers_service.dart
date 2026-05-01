import 'base_tmdb_service.dart';
import '../models/watch_providers/watch_provider_region.dart';
import '../models/watch_providers/watch_providers_response.dart';

/// [WatchProvidersService] handles API interactions related to streaming and rental providers on TMDB.
class WatchProvidersService extends BaseTmdbService {
  WatchProvidersService(super.client);

  /// Get the list of the countries we have watch provider (streaming, rent, buy) data for.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /watch/providers/regions`.
  Future<List<WatchProviderRegion>> getAvailableRegions({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('watch/providers/regions', queryParameters: params);
    return (jsonResponse['results'] as List)
        .map((i) => WatchProviderRegion.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  /// Get the list of streaming providers we have for movies.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /watch/providers/movie`.
  Future<WatchProvidersResponse> getMovieProviders({
    String? language,
    String? watchRegion,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'watch_region': ?watchRegion,
      ...?queryParameters,
    };
    final jsonResponse = await get('watch/providers/movie', queryParameters: params);
    return WatchProvidersResponse.fromJson(jsonResponse);
  }

  /// Get the list of streaming providers we have for TV shows.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /watch/providers/tv`.
  Future<WatchProvidersResponse> getTvProviders({
    String? language,
    String? watchRegion,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'watch_region': ?watchRegion,
      ...?queryParameters,
    };
    final jsonResponse = await get('watch/providers/tv', queryParameters: params);
    return WatchProvidersResponse.fromJson(jsonResponse);
  }
}
