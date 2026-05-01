import 'base_tmdb_service.dart';
import '../models/common/tmdb_business_details.dart';
import '../models/common/alternative_name.dart';
import '../models/common/tmdb_logo.dart';
import '../models/common/tmdb_list_response.dart';

/// [NetworksService] handles API interactions related to TV networks on TMDB.
class NetworksService extends BaseTmdbService {
  NetworksService(super.client);

  /// Get the details of a TV network.
  Future<TmdbBusinessDetails> getDetails(
    int networkId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'network/$networkId',
      queryParameters: queryParameters,
    );
    return TmdbBusinessDetails.fromJson(jsonResponse);
  }

  /// Get the alternative names of a TV network.
  Future<TmdbListResponse<AlternativeName>> getAlternativeNames(
    int networkId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'network/$networkId/alternative_names',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(jsonResponse, AlternativeName.fromJson);
  }

  /// Get the logos of a TV network.
  Future<TmdbListResponse<TmdbLogo>> getLogos(
    int networkId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'network/$networkId/images',
      queryParameters: queryParameters,
    );
    return TmdbListResponse.fromJson(
      jsonResponse,
      TmdbLogo.fromJson,
      resultsKey: 'logos',
    );
  }
}
