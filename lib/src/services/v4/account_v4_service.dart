import 'base_v4_service.dart';
import '../../models/v4/tmdb_v4_list_models.dart';

/// [AccountV4Service] handles API interactions for TMDB v4 account-specific endpoints.
class AccountV4Service extends BaseV4Service {
  AccountV4Service(super.client, super.connection);

  /// Get all lists created by the user.
  ///
  /// [accountId] is the unique identifier for the user (v4 account ID).
  Future<TmdbAccountV4ListsResponse> getLists(
    String accountId, {
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('account/$accountId/lists', queryParameters: params);
    return TmdbAccountV4ListsResponse.fromJson(jsonResponse);
  }
}
