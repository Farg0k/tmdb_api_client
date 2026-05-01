import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/trending_models.dart';
import '../models/people/person_summary.dart';

/// [TrendingService] handles API interactions related to trending items on TMDB.
class TrendingService extends BaseTmdbService {
  TrendingService(super.client);

  /// Get the daily or weekly trending items.
  Future<TmdbResponsePage<Map<String, dynamic>>> getAll(
    TimeWindow timeWindow, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'trending/all/${timeWindow.value}',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, (i) => i);
  }

  /// Get the daily or weekly trending movies.
  Future<TmdbResponsePage<MovieSummary>> getMovies(
    TimeWindow timeWindow, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'trending/movie/${timeWindow.value}',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the daily or weekly trending TV shows.
  Future<TmdbResponsePage<TvSummary>> getTvShows(
    TimeWindow timeWindow, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'trending/tv/${timeWindow.value}',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the daily or weekly trending people.
  Future<TmdbResponsePage<PersonSummary>> getPeople(
    TimeWindow timeWindow, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get(
      'trending/person/${timeWindow.value}',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, PersonSummary.fromJson);
  }
}
