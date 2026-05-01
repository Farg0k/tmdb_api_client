import 'base_tmdb_service.dart';
import '../models/list_models.dart';

/// [ListsService] handles API interactions for TMDB v3 Lists.
class ListsService extends BaseTmdbService {
  ListsService(super.client);

  /// Create a new list.
  Future<TmdbListCreateResponse> create({
    required String name,
    required String description,
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (language != null) 'language': language,
      ...?queryParameters,
    };
    final jsonResponse = await post(
      'list',
      body: {
        'name': name,
        'description': description,
        'language': language ?? 'en-US',
      },
      queryParameters: params,
    );
    return TmdbListCreateResponse.fromJson(jsonResponse);
  }

  /// Get the details of a list.
  Future<TmdbListDetails> getDetails(
    String listId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      if (language != null) 'language': language,
      ...?queryParameters,
    };
    final jsonResponse = await get('list/$listId', queryParameters: params);
    return TmdbListDetails.fromJson(jsonResponse);
  }

  /// Check if a movie is present on a list.
  Future<bool> checkItemStatus(
    String listId,
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'movie_id': movieId.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('list/$listId/item_status', queryParameters: params);
    return jsonResponse['item_present'] == true;
  }

  /// Add a movie to a list.
  Future<TmdbListOperationResponse> addMovie(
    String listId,
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'list/$listId/add_item',
      body: {'media_id': movieId},
      queryParameters: queryParameters,
    );
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }

  /// Remove a movie from a list.
  Future<TmdbListOperationResponse> removeMovie(
    String listId,
    int movieId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'list/$listId/remove_item',
      body: {'media_id': movieId},
      queryParameters: queryParameters,
    );
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }

  /// Clear all items from a list.
  Future<TmdbListOperationResponse> clear(String listId, {Map<String, String>? queryParameters}) async {
    final params = {
      'confirm': 'true',
      ...?queryParameters,
    };
    final jsonResponse = await post('list/$listId/clear', queryParameters: params);
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }

  /// Delete a list.
  Future<TmdbListOperationResponse> deleteList(String listId, {Map<String, String>? queryParameters}) async {
    final jsonResponse = await delete('list/$listId', queryParameters: queryParameters);
    return TmdbListOperationResponse.fromJson(jsonResponse);
  }
}
