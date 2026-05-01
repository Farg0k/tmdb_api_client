import 'base_tmdb_service.dart';
import '../models/common/tmdb_company.dart';
import '../models/common/tmdb_logo.dart';
import '../models/common/tmdb_list_response.dart';
import '../models/company_models.dart';

/// [CompaniesService] handles API interactions related to production companies.
class CompaniesService extends BaseTmdbService {
  CompaniesService(super.client);

  /// Get the metadata for a specific production company.
  Future<TmdbCompany> getDetails(int companyId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('company/$companyId', queryParameters: queryParameters);
    return TmdbCompany.fromJson(jsonResponse);
  }

  /// Get the alternative names for a specific production company.
  Future<TmdbListResponse<AlternativeName>> getAlternativeNames(int companyId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('company/$companyId/alternative_names', queryParameters: queryParameters);
    return TmdbListResponse.fromJson(jsonResponse, AlternativeName.fromJson);
  }

  /// Get the logos for a specific production company.
  Future<TmdbListResponse<TmdbLogo>> getLogos(int companyId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await get('company/$companyId/images', queryParameters: queryParameters);
    return TmdbListResponse.fromJson(jsonResponse, TmdbLogo.fromJson, resultsKey: 'logos');
  }
}
