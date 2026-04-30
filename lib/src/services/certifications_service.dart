import 'base_tmdb_service.dart';
import '../models/certification_models.dart';

/// [CertificationsService] handles API interactions related to Movie and TV certifications (age ratings).
class CertificationsService extends BaseTmdbService {
  CertificationsService(super.client);

  /// Get an up to date list of the officially supported movie certifications on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /certification/movie/list`.
  Future<CertificationsResponse> getMovieCertifications() async {
    final jsonResponse = await get('certification/movie/list');
    return CertificationsResponse.fromJson(jsonResponse);
  }

  /// Get an up to date list of the officially supported TV show certifications on TMDB.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /certification/tv/list`.
  Future<CertificationsResponse> getTvCertifications() async {
    final jsonResponse = await get('certification/tv/list');
    return CertificationsResponse.fromJson(jsonResponse);
  }
}
