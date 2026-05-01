import 'base_tmdb_service.dart';
import '../models/media_models.dart';

/// [GuestSessionsService] handles API interactions related to guest sessions.
class GuestSessionsService extends BaseTmdbService {
  GuestSessionsService(super.client);

  /// Get the rated movies for a guest session.
  Future<TmdbResponsePage<MovieSummary>> getRatedMovies(
    String guestSessionId, {
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('guest_session/$guestSessionId/rated/movies', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the rated TV shows for a guest session.
  Future<TmdbResponsePage<TvSummary>> getRatedTvShows(
    String guestSessionId, {
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('guest_session/$guestSessionId/rated/tv', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the rated TV episodes for a guest session.
  Future<TmdbResponsePage<RatedEpisodeSummary>> getRatedTvEpisodes(
    String guestSessionId, {
    int? page,
    String? sortBy,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('guest_session/$guestSessionId/rated/tv/episodes', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, RatedEpisodeSummary.fromJson);
  }
}
