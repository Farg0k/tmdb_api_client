import '../models/authentication_models.dart'; // Import the data models for authentication.
import 'base_tmdb_service.dart'; // Import the base service class.

/// [AuthenticationService] handles all API interactions related to TMDB authentication.
/// This includes creating request tokens, user sessions, guest sessions, and deleting sessions.
/// It encapsulates the specific endpoints from the `/reference/authentication` documentation.
class AuthenticationService extends BaseTmdbService {
  /// Constructor for [AuthenticationService].
  /// It takes the main [TmdbApiClient] as a dependency via `super(client)`.
  AuthenticationService(super.client);

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
  /// Also, updates the main [TmdbApiClient]'s configuration with this new `sessionId`
  /// so subsequent authenticated requests can automatically use it.
  /// Throws [TmdbApiException] or [TmdbNetworkException] on failure.
  Future<Session> createSession(String requestToken) async {
    final jsonResponse = await post(
      'authentication/session/new',
      body: {'request_token': requestToken}, // The request body includes the approved token.
    );
    final session = Session.fromJson(jsonResponse);
    // Update the main client's configuration with the newly obtained sessionId.
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
  /// If the `sessionIdToDelete` matches the current `sessionId` in the client's config,
  /// the client's `sessionId` will also be cleared.
  /// Returns `true` if the session was successfully deleted, `false` otherwise.
  /// Throws [TmdbApiException] or [TmdbNetworkException] on failure.
  Future<bool> deleteSession(String sessionIdToDelete) async {
    final jsonResponse = await delete(
      'authentication/session',
      body: {'session_id': sessionIdToDelete}, // The request body includes the session ID to delete.
    );
    // If the session being deleted is the one currently stored in the client, clear it.
    if (config.sessionId == sessionIdToDelete) {
      updateClientConfig(config.copyWith(sessionId: null)); // Clear the sessionId in the client.
    }
    return jsonResponse['success'] == true; // TMDB API usually returns {'success': true/false} for this.
  }
}