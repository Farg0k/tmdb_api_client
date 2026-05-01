import 'base_tmdb_service.dart';
import '../models/company_models.dart';

/// [CompaniesService] handles API interactions related to production companies.
class CompaniesService extends BaseTmdbService {
  CompaniesService(super.client);

  /// Get the metadata for a specific production company.
  Future<CompanyDetails> getDetails(int companyId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('company/$companyId', queryParameters: queryParameters);
    return CompanyDetails.fromJson(jsonResponse);
  }

  /// Get the alternative names for a specific production company.
  Future<AlternativeNamesResponse> getAlternativeNames(int companyId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('company/$companyId/alternative_names', queryParameters: queryParameters);
    return AlternativeNamesResponse.fromJson(jsonResponse);
  }

  /// Get the logos for a specific production company.
  Future<CompanyLogosResponse> getLogos(int companyId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('company/$companyId/images', queryParameters: queryParameters);
    return CompanyLogosResponse.fromJson(jsonResponse);
  }
}
