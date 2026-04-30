import '../models/account_models.dart'; // Import the data models for account details.
import '../utils/tmdb_api_exception.dart';
import 'base_tmdb_service.dart'; // Import the base service class.

/// [AccountService] handles all API interactions related to a user's TMDB account.
/// This includes fetching account details.
/// This service requires an authenticated session (`session_id`).
class AccountService extends BaseTmdbService {
  /// Constructor for [AccountService].
  /// It takes the main [TmdbApiClient] as a dependency via `super(client)`.
  AccountService(super.client);

  /// Fetches the details of the currently authenticated user's account.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /account`.
  /// This method **requires a valid `session_id`** to be present in the
  /// [TmdbApiClientConfig]. If no `session_id` is available, this call will fail
  /// with a [TmdbApiException] (e.g., status 401 Unauthorized).
  ///
  /// Returns an [AccountDetails] object containing information about the user.
  /// Throws [TmdbApiException] if the API returns an error (e.g., unauthorized access),
  /// or [TmdbNetworkException] on network-related failures.
  Future<AccountDetails> getDetails() async {
    // Check if a session ID is available before making the request.
    // While the base client will add it to the query, an explicit check here
    // provides clearer error handling for the developer using this service.
    if (config.sessionId == null) {
      throw TmdbApiException(
        'Authentication required. Please create a user session first.',
        statusCode: 401, // Simulate an Unauthorized status.
        errorCode: 3, // TMDB's authentication failed error code.
      );
    }

    final jsonResponse = await get('account');
    return AccountDetails.fromJson(jsonResponse);
  }
}