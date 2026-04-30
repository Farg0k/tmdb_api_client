/// [TmdbApiClientConfig] holds the essential configuration for the TMDB API client.
/// This includes the API key, preferred language, and an optional session ID.
class TmdbApiClientConfig {
  final String apiKey; // Your personal TMDB API key (v3).
  final String language; // Preferred language for API responses (e.g., 'en-US', 'uk-UA').
  final String? sessionId; // Optional: Session ID for authenticated requests. Null if not authenticated.

  /// Constructor for [TmdbApiClientConfig].
  TmdbApiClientConfig({
    required this.apiKey, // API key is mandatory.
    this.language = 'en-US', // Default language is English (US).
    this.sessionId, // Session ID is optional and can be null.
  });

  /// Creates a new [TmdbApiClientConfig] instance with updated values.
  /// This is useful for immutability, allowing you to create a new config
  /// object with changes without modifying the original.
  TmdbApiClientConfig copyWith({
    String? apiKey,
    String? language,
    String? sessionId, // Explicitly allowing null to clear the session ID.
  }) {
    return TmdbApiClientConfig(
      apiKey: apiKey ?? this.apiKey, // If apiKey is null, keep the current one.
      language: language ?? this.language, // If language is null, keep the current one.
      sessionId: sessionId, // This will explicitly set the new sessionId or clear it if null.
    );
  }
}