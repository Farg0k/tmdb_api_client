import '../../tmdb_api_client.dart';
import '../models/tmdb_api_client_config.dart'; // Import the main TmdbApiClient.

/// [BaseTmdbService] is an abstract base class for all specific TMDB API services.
/// It provides a common interface and access to the main [TmdbApiClient]'s
/// HTTP request methods and configuration. This promotes reusability and
/// keeps the client logic centralized.
abstract class BaseTmdbService {
  final TmdbApiClient _client; // A reference to the main TMDB API client.

  /// Constructor for [BaseTmdbService].
  /// Subclasses must call `super(client)` in their constructors.
  BaseTmdbService(this._client);

  /// Delegates a GET request to the main [TmdbApiClient].
  /// This allows services to make HTTP requests without needing direct HTTP client access.
  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) {
    return _client.get(path, queryParameters: queryParameters);
  }

  /// Delegates a POST request to the main [TmdbApiClient].
  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body}) {
    return _client.post(path, body: body);
  }

  /// Delegates a DELETE request to the main [TmdbApiClient].
  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body}) {
    return _client.delete(path, body: body);
  }

  /// Provides access to the current [TmdbApiClientConfig] from the main client.
  TmdbApiClientConfig get config => _client.config;

  /// Allows updating the [TmdbApiClientConfig] in the main client.
  /// This is particularly useful for services that obtain new configuration details
  /// (like a `sessionId`) and need to update the client for future requests.
  void updateClientConfig(TmdbApiClientConfig newConfig) {
    _client.updateConfig(newConfig);
  }
}