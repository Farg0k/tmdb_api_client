import 'base_tmdb_service.dart';
import '../models/list_models.dart';

/// [ListsService] handles API interactions for TMDB v3 Lists.
class ListsService extends BaseTmdbService {
  ListsService(super.client);

  /// Create a new list.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /list`.
  Future<TmdbListCreateResponse> create({
    required String name,
    required String description,
    String language = 'en-US',
  }) async {
    final jsonResponse = await post(
      'list',
      body: {
        'name': name,
        'description': description,
        'language': language,
      },
    );
    return TmdbListCreateResponse.fromJson(jsonResponse);
  }

  /// Get the details of a list.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /list/{list_id}`.
  Future<TmdbListDetails> getDetails(String listId, {String? language}) async {
    final queryParams = {
      'language': ?language,
    };
    final jsonResponse = await get('list/$listId', queryParameters: queryParams);
    return TmdbListDetails.fromJson(jsonResponse);
  }

  /// Check if a movie is present on a list.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /list/{list_id}/item_status`.
  Future<bool> checkItemStatus(String listId, int movieId) async {
    final queryParams = {
      'movie_id': movieId.toString(),
    };
    final jsonResponse = await get('list/$listId/item_status', queryParameters: queryParams);
    return jsonResponse['item_present'] == true;
  }

  /// Add a movie to a list.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /list/{list_id}/add_item`.
  Future<TmdbListOperationResponse> addMovie(String listId, int movieId) async {
    final jsonResponse = await post(
      'list/$listId/add_item',
      body: {'media_id': movieId},
    );
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }

  /// Remove a movie from a list.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /list/{list_id}/remove_item`.
  Future<TmdbListOperationResponse> removeMovie(String listId, int movieId) async {
    final jsonResponse = await post(
      'list/$listId/remove_item',
      body: {'media_id': movieId},
    );
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }

  /// Clear all items from a list.
  ///
  /// Corresponds to the TMDB API endpoint: `POST /list/{list_id}/clear`.
  Future<TmdbListOperationResponse> clear(String listId) async {
    final queryParams = {
      'confirm': 'true',
    };
    final jsonResponse = await post('list/$listId/clear', queryParameters: queryParams);
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }

  /// Delete a list.
  ///
  /// Corresponds to the TMDB API endpoint: `DELETE /list/{list_id}`.
  Future<TmdbListOperationResponse> deleteList(String listId) async {
    final jsonResponse = await delete('list/$listId');
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }
}
