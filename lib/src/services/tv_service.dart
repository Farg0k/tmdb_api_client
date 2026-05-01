import 'base_tmdb_service.dart';
import '../models/media_models.dart';

/// [TvService] handles API interactions related to TV series on TMDB.
///
/// This specific part covers standard TV series lists like Airing Today, Popular, etc.
class TvService extends BaseTmdbService {
  TvService(super.client);

  /// Get a list of TV shows that are airing today.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/airing_today`.
  Future<TmdbResponsePage<TvSummary>> getAiringToday({
    int? page,
    String? language,
    String? timezone,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'timezone': ?timezone,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/airing_today', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get a list of TV shows that are currently on the air.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/on_the_air`.
  Future<TmdbResponsePage<TvSummary>> getOnTheAir({
    int? page,
    String? language,
    String? timezone,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      'timezone': ?timezone,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/on_the_air', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get a list of the current popular TV shows on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/popular`.
  Future<TmdbResponsePage<TvSummary>> getPopular({
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/popular', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the top rated TV shows on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/top_rated`.
  Future<TmdbResponsePage<TvSummary>> getTopRated({
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/top_rated', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }
}
