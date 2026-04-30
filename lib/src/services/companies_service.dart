import 'base_tmdb_service.dart';
import '../models/company_models.dart';

/// [CompaniesService] handles API interactions related to production companies.
class CompaniesService extends BaseTmdbService {
  CompaniesService(super.client);

  /// Get the metadata for a specific production company.
  ///
  /// [companyId] is the unique identifier for the company.
  /// Corresponds to the TMDB API endpoint: `GET /company/{company_id}`.
  Future<CompanyDetails> getDetails(int companyId) async {
    final jsonResponse = await get('company/$companyId');
    return CompanyDetails.fromJson(jsonResponse);
  }

  /// Get the alternative names for a specific production company.
  ///
  /// [companyId] is the unique identifier for the company.
  /// Corresponds to the TMDB API endpoint: `GET /company/{company_id}/alternative_names`.
  Future<AlternativeNamesResponse> getAlternativeNames(int companyId) async {
    final jsonResponse = await get('company/$companyId/alternative_names');
    return AlternativeNamesResponse.fromJson(jsonResponse);
  }

  /// Get the logos for a specific production company.
  ///
  /// [companyId] is the unique identifier for the company.
  /// Corresponds to the TMDB API endpoint: `GET /company/{company_id}/images`.
  Future<CompanyLogosResponse> getLogos(int companyId) async {
    final jsonResponse = await get('company/$companyId/images');
    return CompanyLogosResponse.fromJson(jsonResponse);
  }
}
