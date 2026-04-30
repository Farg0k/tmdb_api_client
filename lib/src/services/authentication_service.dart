// Import the data models for authentication.
import 'base_tmdb_service.dart'; // Import the base service class.
import '../../tmdb_api_client.dart'; // <--- NEW: Import TmdbApiClient for constructor type.

/// [AuthenticationService] handles all API interactions related to TMDB authentication.
/// This includes creating request tokens, user sessions, guest sessions, and deleting sessions.
/// It encapsulates the specific endpoints from the `/reference/authentication` documentation.
class AuthenticationService extends BaseTmdbService {
  /// Constructor for [AuthenticationService].
  /// It takes the main [TmdbApiClient] instance as a dependency, which it passes
  /// to its [BaseTmdbService] superclass.
  AuthenticationService(super.client); // <--- Constructor now takes TmdbApiClient.

  /// 1. Creates a new request token.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /authentication/token/new`.
  /// This token is temporary and must be approved by the user.
  /// Returns a [RequestToken] object containing the token and its expiration.
  /// Throws [TmdbApiException] or [TmdbNetworkException] on failure.
  Future<RequestToken> createRequestToken() async {
    final jsonResponse = await get('authentication/token/new');
    return RequestToken.fromJson(jsonResponse);
  }

  /// 2. Creates a user session from an approved request token.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /authentication/session/new`.
  /// This method should be called *after* the user has approved the [requestToken]
  /// (e.g., by visiting a URL in their browser).
  /// Returns a [Session] object containing the permanent `sessionId`.
  /// Also, updates the shared client configuration with this new `sessionId`
  /// so subsequent authenticated requests can automatically use it.
  /// Throws [TmdbApiException] or [TmdbNetworkException] on failure.
  Future<Session> createSession(String requestToken) async {
    final jsonResponse = await post(
      'authentication/session/new',
      body: {'request_token': requestToken}, // The request body includes the approved token.
    );
    final session = Session.fromJson(jsonResponse);
    // Update the shared configuration (via BaseTmdbService's updateClientConfig) with the new sessionId.
    updateClientConfig(config.copyWith(sessionId: session.sessionId));
    return session;
  }

  /// 3. Creates a guest session.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /authentication/guest_session/new`.
  /// Guest sessions allow limited interactions (e.g., rating content) without user login.
  /// They are temporary and have a limited lifespan.
  /// Returns a [GuestSession] object containing the guest session ID and expiration.
  /// Throws [TmdbApiException] or [TmdbNetworkException] on failure.
  Future<GuestSession> createGuestSession() async {
    final jsonResponse = await get('authentication/guest_session/new');
    return GuestSession.fromJson(jsonResponse);
  }

  /// 4. Deletes an existing user session.
  ///
  /// Corresponds to the TMDB API endpoint: `DELETE /authentication/session`.
  /// This effectively logs the user out and invalidates the provided `sessionIdToDelete`.
  /// If the `sessionIdToDelete` matches the current `sessionId` in the shared config,
  /// the client's `sessionId` will also be cleared.
  /// Returns `true` if the session was successfully deleted, `false` otherwise.
  /// Throws [TmdbApiException] or [TmdbNetworkException] on failure.
  Future<bool> deleteSession(String sessionIdToDelete) async {
    final jsonResponse = await delete(
      'authentication/session',
      body: {'session_id': sessionIdToDelete}, // The request body includes the session ID to delete.
    );
    // If the session being deleted is the one currently stored in the shared config, clear it.
    if (config.sessionId == sessionIdToDelete) {
      updateClientConfig(config.copyWith(sessionId: null)); // Clear the sessionId in the client.
    }
    return jsonResponse['success'] == true; // TMDB API usually returns {'success': true/false} for this.
  }

  /// 5. Validates a request token with a user's TMDB username and password.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /authentication/token/validate_with_login`.
  /// This is often used in mobile or desktop apps to authenticate the user
  /// directly without redirecting to a web browser.
  /// Returns an updated [RequestToken] object that is now "authorized".
  Future<RequestToken> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final jsonResponse = await post(
      'authentication/token/validate_with_login',
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );
    return RequestToken.fromJson(jsonResponse);
  }

  /// 6. Creates a v3 session ID from a v4 access token.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /authentication/session/convert/4`.
  /// This allows you to migrate or use v4 authentication tokens to get a v3 session ID.
  /// Returns a [Session] object containing the `sessionId`.
  Future<Session> createSessionFromV4(String accessTokenV4) async {
    final jsonResponse = await post(
      'authentication/session/convert/4',
      body: {'access_token': accessTokenV4},
    );
    final session = Session.fromJson(jsonResponse);
    updateClientConfig(config.copyWith(sessionId: session.sessionId));
    return session;
  }

  /// 7. Validates the current API key.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /authentication`.
  /// A simple way to check if your API key is valid and working.
  /// Returns `true` if the key is valid, `false` otherwise.
  Future<bool> validateKey() async {
    try {
      final jsonResponse = await get('authentication');
      return jsonResponse['success'] == true;
    } catch (e) {
      return false;
    }
  }
}