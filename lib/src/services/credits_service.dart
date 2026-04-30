import 'base_tmdb_service.dart';
import '../models/credit_models.dart';

/// [CreditsService] handles API interactions related to TMDB Credits.
class CreditsService extends BaseTmdbService {
  CreditsService(super.client);

  /// Get the metadata for a specific credit.
  ///
  /// [creditId] is the unique identifier for the credit.
  /// Corresponds to the TMDB API endpoint: `GET /credit/{credit_id}`.
  Future<CreditDetails> getDetails(String creditId) async {
    final jsonResponse = await get('credit/$creditId');
    return CreditDetails.fromJson(jsonResponse);
  }
}
