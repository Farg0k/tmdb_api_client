import '../../../tmdb_api_client.dart';
import '../../core/tmdb_api_connection_v4.dart';

/// [BaseV4Service] is an abstract base class for all TMDB API v4 services.
abstract class BaseV4Service {
  final TmdbApiClient client;
  final TmdbApiConnectionV4 connection;

  BaseV4Service(this.client, this.connection);

  TmdbApiClientConfig get config => client.config;

  Future<Map<String, dynamic>> get(String path, {Map<String, String>? queryParameters}) {
    return connection.get(path, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return connection.post(path, body: body, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> put(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return connection.put(path, body: body, queryParameters: queryParameters);
  }

  Future<Map<String, dynamic>> delete(String path, {Map<String, dynamic>? body, Map<String, String>? queryParameters}) {
    return connection.delete(path, body: body, queryParameters: queryParameters);
  }
}
