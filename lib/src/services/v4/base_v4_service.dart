import '../../../tmdb_api_client.dart';
import '../../core/tmdb_api_connection_v4.dart';

/// [BaseV4Service] is an abstract base class for all TMDB API v4 services.
abstract class BaseV4Service {
  final TmdbApiClient _client;
  final TmdbApiConnectionV4 _connection;

  BaseV4Service(this._client, this._connection);

  TmdbApiClientConfig get config => _client.config;

  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) {
    return _connection.get(path, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _connection.post(path, body: body, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> put(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _connection.put(path, body: body, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return _connection.delete(path, body: body, queryParameters: queryParameters);
  }
}
