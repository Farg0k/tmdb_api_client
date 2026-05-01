import 'base_tmdb_service.dart';
import '../models/networks/network_details.dart';
import '../models/networks/network_alternative_names.dart';
import '../models/networks/network_logos.dart';

/// [NetworksService] handles API interactions related to TV networks on TMDB.
class NetworksService extends BaseTmdbService {
  NetworksService(super.client);

  /// Get the details of a TV network.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /network/{network_id}`.
  Future<NetworkDetails> getDetails(int networkId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('network/$networkId', queryParameters: queryParameters);
    return NetworkDetails.fromJson(jsonResponse);
  }

  /// Get the alternative names of a TV network.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /network/{network_id}/alternative_names`.
  Future<NetworkAlternativeNamesResponse> getAlternativeNames(int networkId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('network/$networkId/alternative_names', queryParameters: queryParameters);
    return NetworkAlternativeNamesResponse.fromJson(jsonResponse);
  }

  /// Get the logos of a TV network.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /network/{network_id}/images`.
  Future<NetworkLogosResponse> getLogos(int networkId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('network/$networkId/images', queryParameters: queryParameters);
    return NetworkLogosResponse.fromJson(jsonResponse);
  }
}
