import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tmdb_api_client_config.dart';
import '../utils/tmdb_api_exception.dart';

/// [TmdbApiConnectionV4] manages actual HTTP communication with TMDB API v4.
class TmdbApiConnectionV4 {
  static const String _kTmdbBaseUrl = 'api.themoviedb.org';
  static const String _kApiVersion = '4';

  final http.Client _httpClient;
  TmdbApiClientConfig _config;

  TmdbApiConnectionV4({
    required TmdbApiClientConfig config,
    http.Client? httpClient,
  }) : _config = config,
       _httpClient = httpClient ?? http.Client();

  TmdbApiClientConfig get config => _config;

  void updateConfig(TmdbApiClientConfig newConfig) {
    _config = newConfig;
  }

  Map<String, String> get _headers {
    final headers = {'Content-Type': 'application/json'};
    if (_config.accessTokenV4 != null) {
      headers['Authorization'] = 'Bearer ${_config.accessTokenV4}';
    }
    return headers;
  }

  Future<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (_config.language.isNotEmpty) 'language': _config.language,
      ...?queryParameters,
    };

    final uri = Uri.https(_kTmdbBaseUrl, '$_kApiVersion/$path', params);

    try {
      final response = await _httpClient.get(uri, headers: _headers);
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.https(
      _kTmdbBaseUrl,
      '$_kApiVersion/$path',
      queryParameters,
    );

    try {
      final response = await _httpClient.post(
        uri,
        headers: _headers,
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.https(
      _kTmdbBaseUrl,
      '$_kApiVersion/$path',
      queryParameters,
    );

    try {
      final response = await _httpClient.put(
        uri,
        headers: _headers,
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.https(
      _kTmdbBaseUrl,
      '$_kApiVersion/$path',
      queryParameters,
    );

    try {
      final response = await _httpClient.delete(
        uri,
        headers: _headers,
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw TmdbNetworkException('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  dynamic _processResponse(http.Response response) {
    final dynamic jsonBody = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonBody;
    } else {
      final Map<String, dynamic> errorMap = (jsonBody is Map<String, dynamic>)
          ? jsonBody
          : {'status_message': 'Unknown error'};
      throw TmdbApiException(
        errorMap['status_message'] as String? ?? 'Unknown API error',
        statusCode: response.statusCode,
        errorCode: errorMap['status_code'] as int?,
      );
    }
  }

  void close() {
    _httpClient.close();
  }
}
