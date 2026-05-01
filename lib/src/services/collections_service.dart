import 'base_tmdb_service.dart';
import '../models/collection_models.dart';

/// [CollectionsService] handles API interactions related to Movie Collections.
class CollectionsService extends BaseTmdbService {
  CollectionsService(super.client);

  /// Get the metadata for a specific movie collection.
  Future<CollectionDetails> getDetails(
    int collectionId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (language != null) 'language': language,
      ...?queryParameters,
    };
    final jsonResponse = await get('collection/$collectionId', queryParameters: params);
    return CollectionDetails.fromJson(jsonResponse);
  }

  /// Get the images (posters and backdrops) for a specific movie collection.
  Future<CollectionImagesResponse> getImages(
    int collectionId, {
    String? language,
    String? includeImageLanguage,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (language != null) 'language': language,
      if (includeImageLanguage != null) 'include_image_language': includeImageLanguage,
      ...?queryParameters,
    };
    final jsonResponse = await get('collection/$collectionId/images', queryParameters: params);
    return CollectionImagesResponse.fromJson(jsonResponse);
  }

  /// Get the list of translations available for a specific movie collection.
  Future<CollectionTranslationsResponse> getTranslations(
    int collectionId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (language != null) 'language': language,
      ...?queryParameters,
    };
    final jsonResponse = await get('collection/$collectionId/translations', queryParameters: params);
    return CollectionTranslationsResponse.fromJson(jsonResponse);
  }
}
