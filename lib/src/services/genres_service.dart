import 'base_tmdb_service.dart';
import '../models/genre_models.dart';

/// [GenresService] handles API interactions for Movie and TV genres.
class GenresService extends BaseTmdbService {
  GenresService(super.client);

  /// Get the list of official genres for movies.
  Future<GenresResponse> getMovieList({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get('genre/movie/list', queryParameters: params);
    return GenresResponse.fromJson(jsonResponse);
  }

  /// Get the list of official genres for TV shows.
  Future<GenresResponse> getTvList({
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {'language': ?language, ...?queryParameters};
    final jsonResponse = await get('genre/tv/list', queryParameters: params);
    return GenresResponse.fromJson(jsonResponse);
  }
}
