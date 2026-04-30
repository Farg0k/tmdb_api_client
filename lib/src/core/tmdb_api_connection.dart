import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tmdb_api_client_config.dart'; // Needs config for API key, sessionId, etc.
import '../utils/tmdb_api_exception.dart'; // Needs exception classes.

/// Base URL for The Movie Database (TMDB) API.
const String _kTmdbBaseUrl = 'api.themoviedb.org';
/// API Version currently being used.
const String _kApiVersion = '3';

/// [TmdbApiConnection] is the low-level component responsible for making actual HTTP requests
/// to the TMDB API. It encapsulates the details of URL construction, adding common parameters
/// like the API key and session ID, and handling the raw HTTP responses and errors.
///
/// This class acts as the direct communication interface with the TMDB API.
class TmdbApiConnection { // <--- Renamed class
  final http.Client _httpClient; // The underlying HTTP client instance.
  TmdbApiClientConfig _config; // The current configuration, can be updated.

  /// Constructor for [TmdbApiConnection].
  ///
  /// [config] is the initial configuration, which includes `apiKey`, `language`, and `sessionId`.
  /// [httpClient] can be optionally provided for testing purposes (e.g., a MockClient).
  TmdbApiConnection({
    required TmdbApiClientConfig config,
    http.Client? httpClient,
  }) : _config = config,
        _httpClient = httpClient ?? http.Client();

  /// Gets the current configuration.
  TmdbApiClientConfig get config => _config;

  /// Updates the internal configuration.
  /// This is crucial for scenarios like when a `sessionId` is obtained
  /// and needs to be used for subsequent authenticated requests.
  void updateConfig(TmdbApiClientConfig newConfig) {
    _config = newConfig;
  }

  /// Executes a GET request to the TMDB API.
  ///
  /// [path] is the API endpoint path (e.g., 'authentication/token/new').
  /// [queryParameters] are optional key-value pairs for the URL query string.
  ///
  /// Returns a [Future] that resolves to a `Map<String, dynamic>`
  /// representing the JSON response body.
  /// Throws [TmdbApiException] for API-specific errors or [TmdbNetworkException] for network issues.
  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) async {
    final Map<String, String> finalQueryParameters = {
      'api_key': _config.apiKey,
      'language': _config.language,
      ...?queryParameters,
    };

    if (_config.sessionId != null) {
      finalQueryParameters['session_id'] = _config.sessionId!;
    }

    final uri = Uri.https(
      _kTmdbBaseUrl,
      '$_kApiVersion/$path',
      finalQueryParameters,
    );

    try {
      final response = await _httpClient.get(uri);
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  /// Executes a POST request to the TMDB API.
  ///
  /// [path] is the API endpoint path (e.g., 'authentication/session/new').
  /// [body] is the optional request body, which will be JSON encoded.
  ///
  /// Returns a [Future] that resolves to a `Map<String, dynamic>`
  /// representing the JSON response body.
  /// Throws [TmdbApiException] for API-specific errors or [TmdbNetworkException] for network issues.
  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body}) async {
    final Map<String, String> finalQueryParameters = {
      'api_key': _config.apiKey,
    };
    if (_config.sessionId != null) {
      finalQueryParameters['session_id'] = _config.sessionId!;
    }

    final uri = Uri.https(
      _kTmdbBaseUrl,
      '$_kApiVersion/$path',
      finalQueryParameters,
    );

    try {
      final response = await _httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  /// Executes a DELETE request to the TMDB API.
  ///
  /// [path] is the API endpoint path (e.g., 'authentication/session').
  /// [body] is the optional request body, which will be JSON encoded.
  ///
  /// Returns a [Future] that resolves to a `Map<String, dynamic>`
  /// representing the JSON response body.
  /// Throws [TmdbApiException] for API-specific errors or [TmdbNetworkException] for network issues.
  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body}) async {
    final Map<String, String> finalQueryParameters = {
      'api_key': _config.apiKey,
    };
    if (_config.sessionId != null) {
      finalQueryParameters['session_id'] = _config.sessionId!;
    }

    final uri = Uri.https(
      _kTmdbBaseUrl,
      '$_kApiVersion/$path',
      finalQueryParameters,
    );

    try {
      final response = await _httpClient.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  /// Processes a raw HTTP response.
  ///
  /// If the status code indicates success (2xx), it decodes the JSON body.
  /// Otherwise, it throws a [TmdbApiException] with details from the error response.
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = json.decode(response.body);
      throw TmdbApiException(
        'API Error: ${errorBody['status_message'] ?? 'Unknown error'}',
        statusCode: response.statusCode,
        errorCode: errorBody['status_code'] as int?,
      );
    }
  }

  /// Closes the underlying HTTP client.
  ///
  /// It's important to call this when the connection is no longer needed
  /// to release system resources, especially in long-running applications.
  void close() {
    _httpClient.close();
  }
}