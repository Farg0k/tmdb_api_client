import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/tv/tv_episode_summary.dart';

/// [GuestSessionsService] handles API interactions related to guest sessions.
class GuestSessionsService extends BaseTmdbService {
  GuestSessionsService(super.client);

  /// Get the rated movies for a guest session.
  Future<TmdbResponsePage<MovieSummary>> getRatedMovies(
    String guestSessionId, {
    String? language,
    String? sortBy,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'sort_by': ?sortBy,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'guest_session/$guestSessionId/rated/movies',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the rated TV shows for a guest session.
  Future<TmdbResponsePage<TvSummary>> getRatedTvShows(
    String guestSessionId, {
    String? language,
    String? sortBy,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'sort_by': ?sortBy,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'guest_session/$guestSessionId/rated/tv',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the rated TV episodes for a guest session.
  Future<TmdbResponsePage<TvEpisodeSummary>> getRatedTvEpisodes(
    String guestSessionId, {
    String? language,
    String? sortBy,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      'sort_by': ?sortBy,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'guest_session/$guestSessionId/rated/tv/episodes',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, TvEpisodeSummary.fromJson);
  }
}
