import 'base_tmdb_service.dart';
import '../models/find_models.dart';

/// [FindService] handles API interactions for searching media by external IDs.
class FindService extends BaseTmdbService {
  FindService(super.client);

  /// Find movies, TV shows and people by external IDs.
  ///
  /// [externalId] is the ID from the external source.
  /// [externalSource] is the source of the ID (e.g., [ExternalSource.imdbId]).
  /// [language] allows you to specify a language for the results.
  /// [queryParameters] allows passing additional generic parameters.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /find/{external_id}`.
  Future<FindResponse> byExternalId(
    String externalId, {
    required ExternalSource externalSource,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final Map<String, String> params = {
      'external_source': externalSource.value,
      'language': ?language,
      ...?queryParameters,
    };

    final jsonResponse = await get('find/$externalId', queryParameters: params);
    return FindResponse.fromJson(jsonResponse);
  }
}
