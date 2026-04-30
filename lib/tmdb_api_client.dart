import 'dart:convert'; // Used for JSON encoding and decoding.
import 'package:http/http.dart' as http; // Alias 'http' for the HTTP client library.

// Import necessary services.
import 'src/models/tmdb_api_client_config.dart';
import 'src/services/authentication_service.dart';
import 'src/services/account_service.dart';
import 'src/utils/tmdb_api_exception.dart'; // <--- NEW: Import the account service

export 'src/utils/tmdb_api_exception.dart';
export 'src/models/authentication_models.dart';
export 'src/models/tmdb_api_client_config.dart';
/// Base URL for The Movie Database (TMDB) API.
const String _kTmdbBaseUrl = 'api.themoviedb.org';
/// API Version currently being used.
const String _kApiVersion = '3';

/// [TmdbApiClient] serves as the central "orchestrator" for interacting with the TMDB API.
/// It manages the base HTTP client, configuration, and provides access to specific
/// API services (like authentication, account details, etc.).
class TmdbApiClient {
  // Private configuration object, managed internally through `updateConfig`.
  TmdbApiClientConfig _config;
  final http.Client _httpClient; // The underlying HTTP client instance.

  // Public getters to access the different services.
  // 'late final' ensures they are initialized once in the constructor.
  late final AuthenticationService authentication;
  late final AccountService account; // <--- NEW: Public getter for AccountService

  /// Constructor for [TmdbApiClient].
  /// [config] is the initial configuration for the API client.
  /// [httpClient] can be provided for testing purposes (e.g., MockClient).
  TmdbApiClient({
    required TmdbApiClientConfig config,
    http.Client? httpClient,
  }) : _config = config,
        _httpClient = httpClient ?? http.Client() {
    // Initialize all currently included services.
    // Each service gets a reference to this client to perform requests and update config.
    authentication = AuthenticationService(this);
    account = AccountService(this); // <--- NEW: Initialize the account service
  }

  /// Public getter to access the current configuration of the client.
  TmdbApiClientConfig get config => _config;

  /// Allows updating the client's configuration.
  /// This is crucial for scenarios like updating the `sessionId` after authentication.
  void updateConfig(TmdbApiClientConfig newConfig) {
    _config = newConfig;
  }

  /// Internal base method for making authenticated or unauthenticated GET requests to the TMDB API.
  /// All service-specific GET methods will call this.
  /// [path] is the API endpoint path (e.g., 'authentication/token/new').
  /// [queryParameters] are optional key-value pairs for the URL query string.
  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) async {
    // Assemble common query parameters including API key and language.
    final Map<String, String> finalQueryParameters = {
      'api_key': _config.apiKey,
      'language': _config.language,
      ...?queryParameters, // Add any specific query parameters provided.
    };

    // If a sessionId is present in the config, include it in the query parameters.
    if (_config.sessionId != null) {
      finalQueryParameters['session_id'] = _config.sessionId!;
    }

    // Construct the full URI for the request.
    final uri = Uri.https(
      _kTmdbBaseUrl, // Host: api.themoviedb.org
      '$_kApiVersion/$path', // Path: /3/authentication/token/new
      finalQueryParameters, // All assembled query parameters.
    );

    try {
      // Execute the GET request.
      final response = await _httpClient.get(uri);
      // Process the HTTP response (check status code, decode JSON).
      return _processResponse(response);
    } on http.ClientException catch (e) {
      // Catch network-related errors (e.g., no internet connection).
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      // Re-throw any other unexpected errors.
      rethrow;
    }
  }

  /// Internal base method for making authenticated or unauthenticated POST requests to the TMDB API.
  /// All service-specific POST methods will call this.
  /// [path] is the API endpoint path (e.g., 'authentication/session/new').
  /// [body] is the optional request body, which will be JSON encoded.
  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body}) async {
    // Assemble common query parameters including API key. Language is often not needed for POST auth.
    final Map<String, String> finalQueryParameters = {
      'api_key': _config.apiKey,
      // Add sessionId if present, for authenticated POST requests.
      // Although for session creation it's usually in the body or not needed for the POST URL.
      // We keep it here for consistency for future authenticated POST endpoints.
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

  /// Internal base method for making authenticated or unauthenticated DELETE requests to the TMDB API.
  /// All service-specific DELETE methods will call this.
  /// [path] is the API endpoint path (e.g., 'authentication/session').
  /// [body] is the optional request body, which will be JSON encoded.
  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body}) async {
    final Map<String, String> finalQueryParameters = {
      'api_key': _config.apiKey,
    };
    // Add sessionId if present.
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
  /// If the status code indicates success (2xx), it decodes the JSON body.
  /// Otherwise, it throws a [TmdbApiException] with details from the error response.
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Decode the JSON response body.
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      // For error responses, try to parse the error message and code from the body.
      final errorBody = json.decode(response.body);
      throw TmdbApiException(
        'API Error: ${errorBody['status_message'] ?? 'Unknown error'}',
        statusCode: response.statusCode,
        errorCode: errorBody['status_code'] as int?,
      );
    }
  }

  /// Closes the underlying HTTP client.
  /// It's important to call this when the client is no longer needed
  /// to release system resources, especially in long-running applications.
  void close() {
    _httpClient.close();
  }
}