/// [TmdbApiClientConfig] holds the essential configuration for the TMDB API client.
/// This includes the API key, preferred language, and an optional session ID.
class TmdbApiClientConfig {
  final String apiKey; // Your personal API Key from TMDB.
  final String language; // Preferred language (e.g., 'en-US', 'uk-UA').
  final String?
  sessionId; // (Optional) User-specific session ID for authenticated requests.
  final String? accessTokenV4; // (Optional) V4 Access Token (Bearer Token).

  TmdbApiClientConfig({
    required this.apiKey,
    this.language = 'en-US',
    this.sessionId,
    this.accessTokenV4,
  });

  /// Allows creating a new configuration based on the current one, with some fields updated.
  TmdbApiClientConfig copyWith({
    String? apiKey,
    String? language,
    String? sessionId,
    String? accessTokenV4,
  }) {
    return TmdbApiClientConfig(
      apiKey: apiKey ?? this.apiKey,
      language: language ?? this.language,
      sessionId: sessionId ?? this.sessionId,
      accessTokenV4: accessTokenV4 ?? this.accessTokenV4,
    );
  }
}
