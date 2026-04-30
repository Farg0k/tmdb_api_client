import 'base_tmdb_service.dart';
import '../models/keyword_models.dart';
import '../models/media_models.dart';

/// [KeywordsService] handles API interactions related to TMDB keywords.
class KeywordsService extends BaseTmdbService {
  KeywordsService(super.client);

  /// Get the metadata for a specific keyword.
  ///
  /// [keywordId] is the unique identifier for the keyword.
  /// Corresponds to the TMDB API endpoint: `GET /keyword/{keyword_id}`.
  Future<Keyword> getDetails(int keywordId) async {
    final jsonResponse = await get('keyword/$keywordId');
    return Keyword.fromJson(jsonResponse);
  }

  /// Get a paginated list of movies associated with a specific keyword.
  ///
  /// [keywordId] is the unique identifier for the keyword.
  /// [includeAdult] whether to include adult content in the results.
  /// [language] allows you to specify a language for the results.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /keyword/{keyword_id}/movies`.
  Future<TmdbResponsePage<MovieSummary>> getMovies(
    int keywordId, {
    bool includeAdult = false,
    String? language,
  }) async {
    final queryParams = {
      'include_adult': includeAdult.toString(),
      'language': ?language,
    };
    final jsonResponse = await get('keyword/$keywordId/movies', queryParameters: queryParams);
    return TmdbResponsePage.fromJson(jsonResponse, MovieSummary.fromJson);
  }
}
