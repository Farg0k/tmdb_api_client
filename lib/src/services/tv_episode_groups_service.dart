import 'base_tmdb_service.dart';
import '../models/tv/episode_groups/tv_episode_group_details.dart';

/// [TvEpisodeGroupsService] handles API interactions related to TV episode groups on TMDB.
class TvEpisodeGroupsService extends BaseTmdbService {
  TvEpisodeGroupsService(super.client);

  /// Get the details of a TV episode group.
  ///
  /// Corresponds to the TMDB API endpoint: `GET /tv/episode_group/{id}`.
  Future<TvEpisodeGroupDetails> getDetails(
    String groupId, {
    String? language,
    Map<String, String>? queryParameters,
  }) async {
    final params = {
      'language': ?language,
      ...?queryParameters,
    };
    final jsonResponse = await get('tv/episode_group/$groupId', queryParameters: params);
    return TvEpisodeGroupDetails.fromJson(jsonResponse);
  }
}
