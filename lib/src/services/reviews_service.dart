import 'base_tmdb_service.dart';
import '../models/reviews/review_details.dart';

/// [ReviewsService] handles API interactions related to reviews on TMDB.
class ReviewsService extends BaseTmdbService {
  ReviewsService(super.client);

  /// Retrieve the details of a specific review.
  Future<ReviewDetails> getDetails(
    String reviewId, {
    Map<String, String>? queryParameters,
  }) async {
    final jsonResponse = await get(
      'review/$reviewId',
      queryParameters: queryParameters,
    );
    return ReviewDetails.fromJson(jsonResponse);
  }
}
