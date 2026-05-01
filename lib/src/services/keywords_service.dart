import 'base_tmdb_service.dart';
import '../models/keyword_models.dart';
import '../models/media_models.dart';

/// [KeywordsService] handles API interactions related to TMDB keywords.
class KeywordsService extends BaseTmdbService {
  KeywordsService(super.client);

  /// Get the metadata for a specific keyword.
  Future<Keyword> getDetails(
    int keywordId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'keyword/$keywordId',
      queryParameters: queryParameters,
    );
    return Keyword.fromJson(jsonResponse);
  }

  /// Get a paginated list of movies associated with a specific keyword.
  Future<TmdbResponsePage<MovieSummary>> getMovies(
    int keywordId, {
    bool includeAdult = false,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'include_adult': includeAdult.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get(
      'keyword/$keywordId/movies',
      queryParameters: params,
    );
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }
}
