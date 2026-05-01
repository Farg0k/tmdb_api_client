import 'base_tmdb_service.dart';
import '../../tmdb_api_client.dart';

/// [AuthenticationService] handles all API interactions related to TMDB authentication.
class AuthenticationService extends BaseTmdbService {
  AuthenticationService(super.client);

  /// 1. Creates a temporary request token.
  Future<RequestToken> createRequestToken({
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'authentication/token/new',
      queryParameters: queryParameters,
    );
    return RequestToken.fromJson(jsonResponse);
  }

  /// 2. Creates a fully authorized session ID.
  Future<Session> createSession(
    String requestToken, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'authentication/session/new',
      body: {'request_token': requestToken},
      queryParameters: queryParameters,
    );
    final session = Session.fromJson(jsonResponse);
    updateClientConfig(config.copyWith(sessionId: session.sessionId));
    return session;
  }

  /// 3. Creates a new guest session.
  Future<GuestSession> createGuestSession({
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'authentication/guest_session/new',
      queryParameters: queryParameters,
    );
    return GuestSession.fromJson(jsonResponse);
  }

  /// 4. Deletes an existing session.
  Future<bool> deleteSession(
    String sessionId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await delete(
      'authentication/session',
      body: {'session_id': sessionId},
      queryParameters: queryParameters,
    );
    if (config.sessionId == sessionId) {
      updateClientConfig(config.copyWith(sessionId: null));
    }
    return jsonResponse['success'] == true;
  }

  /// 5. Validates a request token with a user's TMDB username and password.
  Future<RequestToken> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'authentication/token/validate_with_login',
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
      queryParameters: queryParameters,
    );
    return RequestToken.fromJson(jsonResponse);
  }

  /// 6. Creates a v3 session ID from a v4 access token.
  Future<Session> createSessionFromV4(
    String accessTokenV4, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'authentication/session/convert/4',
      body: {'access_token': accessTokenV4},
      queryParameters: queryParameters,
    );
    final session = Session.fromJson(jsonResponse);
    updateClientConfig(config.copyWith(sessionId: session.sessionId));
    return session;
  }

  /// 7. Validates the current API key.
  Future<bool> validateKey({Map<String, String>? queryParameters}) async {
    try {
      final jsonResponse = await get(
        'authentication',
        queryParameters: queryParameters,
      );
      return jsonResponse['success'] == true;
    } catch (e) {
      return false;
    }
  }
}
