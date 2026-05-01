import 'base_tmdb_service.dart';
import '../models/media_models.dart';
import '../models/people/person_summary.dart';

/// [PeopleService] handles API interactions related to people on TMDB.
class PeopleService extends BaseTmdbService {
  PeopleService(super.client);

  /// Get a list of people ordered by popularity.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /person/popular`.
  Future<TmdbResponsePage<PersonSummary>> getPopular({
    int? page,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('person/popular', queryParameters: params);
    return TmdbResponsePage.fromJson(jsonResponse, PersonSummary.fromJson);
  }
}
