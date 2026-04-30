import 'base_tmdb_service.dart';
import '../models/media_models.dart';

/// [GuestSessionsService] handles API interactions related to guest sessions.
///
/// This includes retrieving rated movies, TV shows, and TV episodes for a guest session.
class GuestSessionsService extends BaseTmdbService {
  GuestSessionsService(super.client);

  /// Get the rated movies for a guest session.
  ///
  /// [guestSessionId] is the unique identifier for the guest session.
  /// Corresponds to the TMDB API endpoint: `GET /guest_session/{guest_session_id}/rated/movies`.
  Future<TmdbResponsePage<MovieSummary>> getRatedMovies(
    String guestSessionId, {
    int page = 1,
    String? sortBy,
    String? language,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
    };
    final jsonResponse = await get('guest_session/$guestSessionId/rated/movies', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the rated TV shows for a guest session.
  ///
  /// [guestSessionId] is the unique identifier for the guest session.
  /// Corresponds to the TMDB API endpoint: `GET /guest_session/{guest_session_id}/rated/tv`.
  Future<TmdbResponsePage<TvSummary>> getRatedTvShows(
    String guestSessionId, {
    int page = 1,
    String? sortBy,
    String? language,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
    };
    final jsonResponse = await get('guest_session/$guestSessionId/rated/tv', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, TvSummary.fromJson);
  }

  /// Get the rated TV episodes for a guest session.
  ///
  /// [guestSessionId] is the unique identifier for the guest session.
  /// Corresponds to the TMDB API endpoint: `GET /guest_session/{guest_session_id}/rated/tv/episodes`.
  Future<TmdbResponsePage<RatedEpisodeSummary>> getRatedTvEpisodes(
    String guestSessionId, {
    int page = 1,
    String? sortBy,
    String? language,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': ?sortBy,
      'language': ?language,
    };
    final jsonResponse = await get('guest_session/$guestSessionId/rated/tv/episodes', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, RatedEpisodeSummary.fromJson);
  }
}
