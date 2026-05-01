import 'base_tmdb_service.dart';
import '../models/common/tmdb_watch_provider.dart';
import '../models/watch_providers/watch_provider_region.dart';
import '../models/common/tmdb_list_response.dart';

/// [WatchProvidersService] handles API interactions related to streaming and rental providers on TMDB.
class WatchProvidersService extends BaseTmdbService {
  WatchProvidersService(super.client);

  /// Get the list of the countries we have watch provider (streaming, rent, buy) data for.
  Future<List<WatchProviderRegion>> getAvailableRegions({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'watch/providers/regions',
      queryParameters: params,
    );
    return (jsonResponse['results'] as List)
        .map((i) => WatchProviderRegion.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  /// Get the list of streaming providers we have for movies.
  Future<TmdbListResponse<WatchProvider>> getMovieProviders({
    String? language,
    String? watchRegion,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'watch_region': ?watchRegion,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'watch/providers/movie',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, WatchProvider.fromJson);
  }

  /// Get the list of streaming providers we have for TV shows.
  Future<TmdbListResponse<WatchProvider>> getTvProviders({
    String? language,
    String? watchRegion,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'watch_region': ?watchRegion,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'watch/providers/tv',
      queryParameters: params,
    );
    return TmdbListResponse.fromJson(jsonResponse, WatchProvider.fromJson);
  }
}
