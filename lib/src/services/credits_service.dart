import 'base_tmdb_service.dart';
import '../models/credit_models.dart';

/// [CreditsService] handles API interactions related to TMDB Credits.
class CreditsService extends BaseTmdbService {
  CreditsService(super.client);

  /// Get the metadata for a specific credit.
  Future<CreditDetails> getDetails(
    String creditId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('credit/$creditId', queryParameters: params);
    return CreditDetails.fromJson(jsonResponse);
  }
}
