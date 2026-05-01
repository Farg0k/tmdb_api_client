import 'base_tmdb_service.dart';
import '../models/certification_models.dart';

/// [CertificationsService] handles API interactions related to Movie and TV certifications (age ratings).
class CertificationsService extends BaseTmdbService {
  CertificationsService(super.client);

  /// Get an up to date list of the officially supported movie certifications on TMDB.
  Future<CertificationsResponse> getMovieCertifications({
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'certification/movie/list',
      queryParameters: queryParameters,
    );
    return CertificationsResponse.fromJson(jsonResponse);
  }

  /// Get an up to date list of the officially supported TV show certifications on TMDB.
  Future<CertificationsResponse> getTvCertifications({
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'certification/tv/list',
      queryParameters: queryParameters,
    );
    return CertificationsResponse.fromJson(jsonResponse);
  }
}
