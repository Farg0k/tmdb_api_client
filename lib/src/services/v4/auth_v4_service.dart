import 'base_v4_service.dart';

/// [AuthV4Service] handles API interactions for TMDB v4 authentication.
class AuthV4Service extends BaseV4Service {
  AuthV4Service(super.client, super.connection);

  /// Create a request token.
  Future<Map<String, dynamic>> createRequestToken({
    String? redirectTo,
    Map<String, String>? queryParameters,
  }) async {
    final body = {'redirect_to': ?redirectTo};
    return post(
      'auth/request_token',
      body: body,
      queryParameters: queryParameters,
    );
  }

  /// Create an access token (Bearer Token) from a validated request token.
  Future<Map<String, dynamic>> createAccessToken(
    String requestToken, {
    Map<String, String>? queryParameters,
  }) async {
    final body = {'request_token': requestToken};
    final jsonResponse = await post(
      'auth/access_token',
      body: body,
      queryParameters: queryParameters,
    );

    if (jsonResponse['access_token'] != null) {
      final newToken = jsonResponse['access_token'] as String;
      client.updateConfig(config.copyWith(accessTokenV4: newToken));
    }

    return jsonResponse;
  }

  /// Delete an access token (Logout).
  Future<bool> deleteAccessToken(
    String accessToken, {
    Map<String, String>? queryParameters,
  }) async {
    final body = {'access_token': accessToken};
    final jsonResponse = await delete(
      'auth/access_token',
      body: body,
      queryParameters: queryParameters,
    );

    if (jsonResponse['success'] == true &&
        config.accessTokenV4 == accessToken) {
      client.updateConfig(config.copyWith(accessTokenV4: null));
    }

    return jsonResponse['success'] == true;
  }
}
