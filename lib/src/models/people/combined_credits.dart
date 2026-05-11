import '../common/tmdb_credit.dart';

/// [CombinedCredits] represents combined movie and TV credits for a person.
/// Returned by the /person/{person_id}/combined_credits (or /credits) endpoint.
class CombinedCredits {
  final int id;
  final TmdbCredits movieCredits;
  final TmdbCredits tvCredits;

  CombinedCredits({
    required this.id,
    required this.movieCredits,
    required this.tvCredits,
  });

  factory CombinedCredits.fromJson(Map<String, dynamic> json) {
    return CombinedCredits(
      id: json['id'] as int,
      movieCredits: TmdbCredits.fromJson(
        json['movie_credits'] as Map<String, dynamic>,
      ),
      tvCredits: TmdbCredits.fromJson(
        json['tv_credits'] as Map<String, dynamic>,
      ),
    );
  }
}
