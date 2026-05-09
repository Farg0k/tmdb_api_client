import 'base_v4_service.dart';
import '../../models/v4/tmdb_v4_list_details.dart';
import '../../models/v4/tmdb_v4_list_create_response.dart';
import '../../models/v4/tmdb_v4_list_operation_response.dart';
import '../../models/enums.dart';
import '../../models/media_models.dart';

/// [ListsV4Service] handles API interactions for TMDB v4 Lists.
class ListsV4Service extends BaseV4Service {
  ListsV4Service(super.client, super.connection);

  /// Get the details of a v4 list.
  Future<TmdbListV4Details> getDetails(
    int listId, {
    String? language,
    int? page,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      if (page != null) 'page': page.toString(),
      ...?queryParameters,
    };
    final jsonResponse = await get('list/$listId', queryParameters: params);
    return TmdbListV4Details.fromJson(jsonResponse);
  }

  /// Create a new v4 list.
  Future<TmdbListV4CreateResponse> create({
    required String name,
    String? description,
    bool public = false,
    String iso_639_1 = 'en',
    String? iso_3166_1,
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'list',
      body: {
        'name': name,
        'description': ?description,
        'public': public,
        'iso_639_1': iso_639_1,
        'iso_3166_1': ?iso_3166_1,
      },
      queryParameters: queryParameters,
    );
    return TmdbListV4CreateResponse.fromJson(jsonResponse);
  }

  /// Update a v4 list metadata.
  Future<TmdbListV4OperationResponse> update(
    int listId, {
    String? name,
    String? description,
    bool? public,
    ListSortByV4? sortBy,
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await put(
      'list/$listId',
      body: {
        'name': ?name,
        'description': ?description,
        'public': ?public,
        'sort_by': ?sortBy?.value,
      },
      queryParameters: queryParameters,
    );
    return TmdbListV4OperationResponse.fromJson(jsonResponse);
  }

  /// Delete a v4 list.
  Future<TmdbListV4OperationResponse> deleteList(
    int listId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await delete(
      'list/$listId',
      queryParameters: queryParameters,
    );
    return TmdbListV4OperationResponse.fromJson(jsonResponse);
  }

  /// Add items to a v4 list.
  Future<TmdbListV4OperationResponse> addItems(
    int listId,
    List<TmdbV4InputItem> items, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await post(
      'list/$listId/items',
      body: {'items': items.map((e) => e.toJson()).toList()},
      queryParameters: queryParameters,
    );
    return TmdbListV4OperationResponse.fromJson(jsonResponse);
  }

  /// Update items in a v4 list (e.g., change comment).
  Future<TmdbListV4OperationResponse> updateItems(
    int listId,
    List<TmdbV4InputItem> items, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await put(
      'list/$listId/items',
      body: {'items': items.map((e) => e.toJson()).toList()},
      queryParameters: queryParameters,
    );
    return TmdbListV4OperationResponse.fromJson(jsonResponse);
  }

  /// Remove items from a v4 list.
  Future<TmdbListV4OperationResponse> removeItems(
    int listId,
    List<TmdbV4InputItem> items, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await delete(
      'list/$listId/items',
      body: {'items': items.map((e) => e.toJson()).toList()},
      queryParameters: queryParameters,
    );
    return TmdbListV4OperationResponse.fromJson(jsonResponse);
  }

  /// Check if a movie or TV show is in a list.
  Future<Map<String, dynamic>> checkItemStatus(
    int listId, {
    required int mediaId,
    required TmdbMediaType mediaType,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'media_id': mediaId.toString(),
      'media_type': mediaType.value,
      ...?queryParameters,
    };
    return (await get('list/$listId/item_status', queryParameters: params) as Map<String, dynamic>);
  }
}

/// [TmdbV4InputItem] represents an item to be added/updated in a v4 list.
class TmdbV4InputItem {
  final int mediaId;
  final TmdbMediaType mediaType;
  final String? comment;

  TmdbV4InputItem({
    required this.mediaId,
    required this.mediaType,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'media_id': mediaId,
      'media_type': mediaType.value,
      if (comment != null) 'comment': comment,
    };
  }
}
