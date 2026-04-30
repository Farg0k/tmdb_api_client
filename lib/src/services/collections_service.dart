import 'base_tmdb_service.dart';
import '../models/collection_models.dart';

/// [CollectionsService] handles API interactions related to Movie Collections.
///
/// Collections are groups of movies, like the "Avengers Collection" or "Die Hard Collection".
class CollectionsService extends BaseTmdbService {
  CollectionsService(super.client);

  /// Get the metadata for a specific movie collection.
  ///
  /// [collectionId] is the unique identifier for the collection.
  /// Corresponds to the TMDB API endpoint: `GET /collection/{collection_id}`.
  Future<CollectionDetails> getDetails(int collectionId) async {
    final jsonResponse = await get('collection/$collectionId');
    return CollectionDetails.fromJson(jsonResponse);
  }

  /// Get the images (posters and backdrops) for a specific movie collection.
  ///
  /// [collectionId] is the unique identifier for the collection.
  /// Corresponds to the TMDB API endpoint: `GET /collection/{collection_id}/images`.
  Future<CollectionImagesResponse> getImages(int collectionId) async {
    final jsonResponse = await get('collection/$collectionId/images');
    return CollectionImagesResponse.fromJson(jsonResponse);
  }

  /// Get the list of translations available for a specific movie collection.
  ///
  /// [collectionId] is the unique identifier for the collection.
  /// Corresponds to the TMDB API endpoint: `GET /collection/{collection_id}/translations`.
  Future<CollectionTranslationsResponse> getTranslations(int collectionId) async {
    final jsonResponse = await get('collection/$collectionId/translations');
    return CollectionTranslationsResponse.fromJson(jsonResponse);
  }
}
