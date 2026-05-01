import '../../tmdb_api_client.dart';
// Import the main TmdbApiClient.

/// [BaseTmdbService] is an abstract base class for all specific TMDB API services.
/// It provides a common interface and access to the main [TmdbApiClient]'s
/// HTTP request methods and configuration. This promotes reusability and
/// keeps the client logic centralized.
import '../core/tmdb_api_connection.dart'; // <--- UPDATED: Import the API connection class.
// Needs to import config separately.
// Also need to import TmdbApiClient for type hinting (can be optimized if not strictly needed)

/// [BaseTmdbService] is an abstract base class for all specific TMDB API services.
/// It provides a common interface and access to the [TmdbApiConnection]'s
/// HTTP request methods and the shared client configuration.
///
/// This promotes reusability and keeps the low-level HTTP client logic centralized
/// within [TmdbApiConnection].
abstract class BaseTmdbService {
  // The main client instance, used to delegate configuration updates to the _apiConnection.
  final TmdbApiClient
  _client; // <--- The service needs a reference to the main client.

  /// Constructor for [BaseTmdbService].
  /// Subclasses must call `super(client)` in their constructors.
  BaseTmdbService(this._client); // <--- Constructor now takes TmdbApiClient.

  /// Delegates a GET request to the internal [TmdbApiConnection] via the main client.
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
  }) {
    return _client.get(path, queryParameters: queryParameters);
  }

  /// Delegates a POST request to the internal [TmdbApiConnection] via the main client.
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) {
    return _client.post(path, body: body, queryParameters: queryParameters);
  }

  /// Delegates a DELETE request to the internal [TmdbApiConnection] via the main client.
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) {
    return _client.delete(path, body: body, queryParameters: queryParameters);
  }

  /// Provides access to the current [TmdbApiClientConfig] from the main client's connection.
  TmdbApiClientConfig get config => _client.config;

  /// Allows updating the [TmdbApiClientConfig] in the main client's connection.
  /// This is particularly useful for services that obtain new configuration details
  /// (like a `sessionId`) and need to update the client for future requests.
  void updateClientConfig(TmdbApiClientConfig newConfig) {
    _client.updateConfig(newConfig);
  }
}
