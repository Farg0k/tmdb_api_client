/// [RequestToken] represents the response structure for creating a new request token
/// from the TMDB API's `/authentication/token/new` endpoint.
class RequestToken {
  final bool success; // Indicates if the token creation was successful.
  final String expiresAt; // The expiration date and time of the request token.
  final String requestToken; // The actual request token string.

  /// Constructor for [RequestToken].
  RequestToken({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  /// Factory constructor to create a [RequestToken] instance from a JSON map.
  /// This is commonly used when parsing API responses.
  factory RequestToken.fromJson(Map<String, dynamic> json) {
    return RequestToken(
      success: json['success'] as bool, // Cast 'success' field to boolean.
      expiresAt: json['expires_at'] as String, // Cast 'expires_at' field to string.
      requestToken: json['request_token'] as String, // Cast 'request_token' field to string.
    );
  }
}

/// [Session] represents the response structure for creating a new user session
/// from the TMDB API's `/authentication/session/new` endpoint.
class Session {
  final bool success; // Indicates if the session creation was successful.
  final String sessionId; // The unique ID for the user's authenticated session.

  /// Constructor for [Session].
  Session({
    required this.success,
    required this.sessionId,
  });

  /// Factory constructor to create a [Session] instance from a JSON map.
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      success: json['success'] as bool, // Cast 'success' field to boolean.
      sessionId: json['session_id'] as String, // Cast 'session_id' field to string.
    );
  }
}

/// [GuestSession] represents the response structure for creating a new guest session
/// from the TMDB API's `/authentication/guest_session/new` endpoint.
/// Guest sessions are temporary and do not require user login.
class GuestSession {
  final bool success; // Indicates if the guest session creation was successful.
  final String guestSessionId; // The unique ID for the guest session.
  final String expiresAt; // The expiration date and time of the guest session.

  /// Constructor for [GuestSession].
  GuestSession({
    required this.success,
    required this.guestSessionId,
    required this.expiresAt,
  });

  /// Factory constructor to create a [GuestSession] instance from a JSON map.
  factory GuestSession.fromJson(Map<String, dynamic> json) {
    return GuestSession(
      success: json['success'] as bool, // Cast 'success' field to boolean.
      guestSessionId: json['guest_session_id'] as String, // Cast 'guest_session_id' field to string.
      expiresAt: json['expires_at'] as String, // Cast 'expires_at' field to string.
    );
  }
}