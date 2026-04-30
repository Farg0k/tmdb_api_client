import 'base_tmdb_service.dart';
import '../models/media_models.dart';

/// [MoviesService] handles API interactions related to movies on TMDB.
///
/// This specific part covers standard movie lists like Now Playing, Popular, etc.
class MoviesService extends BaseTmdbService {
  MoviesService(super.client);

  /// Get a list of movies that are currently in theatres.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/now_playing`.
  Future<TmdbResponsePage<MovieSummary>> getNowPlaying({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/now_playing', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of the current popular movies on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/popular`.
  Future<TmdbResponsePage<MovieSummary>> getPopular({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/popular', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get the top rated movies on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/top_rated`.
  Future<TmdbResponsePage<MovieSummary>> getTopRated({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/top_rated', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }

  /// Get a list of upcoming movies in theatres.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /movie/upcoming`.
  Future<TmdbResponsePage<MovieSummary>> getUpcoming({
    int page = 1,
    String? language,
    String? region,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'language': ?language,
      'region': ?region,
    };
    final jsonResponse = await get('movie/upcoming', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }
}
