import 'base_tmdb_service.dart';
import '../models/genre_models.dart';

/// [GenresService] handles API interactions for Movie and TV genres.
class GenresService extends BaseTmdbService {
  GenresService(super.client);

  /// Get the list of official genres for movies.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /genre/movie/list`.
  Future<GenresResponse> getMovieList({String? language}) async {
    final Map<String, String> queryParams = {
      'language': ?language,
    };
    final jsonResponse = await get('genre/movie/list', queryParameters: queryParams);
    return GenresResponse.fromJson(jsonResponse);
  }

  /// Get the list of official genres for TV shows.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /genre/tv/list`.
  Future<GenresResponse> getTvList({String? language}) async {
    final Map<String, String> queryParams = {
      'language': ?language,
    };
    final jsonResponse = await get('genre/tv/list', queryParameters: queryParams);
    return GenresResponse.fromJson(jsonResponse);
  }
}
