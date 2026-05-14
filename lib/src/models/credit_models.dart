import 'tv/tv_episode_summary.dart';
import 'tv/tv_season_summary.dart';

/// [CreditDetails] represents the full information about a specific credit (cast or crew).
class CreditDetails {
  final String creditType;
  final String department;
  final String job;
  final MediaCredit media;
  final String id;
  final PersonCredit person;

  CreditDetails({
    required this.creditType,
    required this.department,
    required this.job,
    required this.media,
    required this.id,
    required this.person,
  });

  factory CreditDetails.fromJson(Map<String, dynamic> json) {
    return CreditDetails(
      creditType: json['credit_type'] as String,
      department: json['department'] as String? ?? '',
      job: json['job'] as String? ?? '',
      media: MediaCredit.fromJson(json['media'] as Map<String, dynamic>),
      id: json['id'] as String,
      person: PersonCredit.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}

/// [MediaCredit] represents the movie or TV show associated with a credit.
class MediaCredit {
  final int id;
  final String? name;
  final String? title;
  final String? originalName;
  final String? originalTitle;
  final String? character;
  final List<TvEpisodeSummary>? episodes;
  final List<TvSeasonSummary>? seasons;

  MediaCredit({
    required this.id,
    this.name,
    this.title,
    this.originalName,
    this.originalTitle,
    this.character,
    this.episodes,
    this.seasons,
  });

  factory MediaCredit.fromJson(Map<String, dynamic> json) {
    return MediaCredit(
      id: json['id'] as int,
      name: json['name'] as String?,
      title: json['title'] as String?,
      originalName: json['original_name'] as String?,
      originalTitle: json['original_title'] as String?,
      character: json['character'] as String?,
      episodes: (json['episodes'] as List?)
          ?.map((i) => TvEpisodeSummary.fromJson(i as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List?)
          ?.map((i) => TvSeasonSummary.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  String get displayName => title ?? name ?? 'Unknown';
}

/// [PersonCredit] represents the person associated with a credit.
class PersonCredit {
  final int id;
  final String name;

  PersonCredit({required this.id, required this.name});

  factory PersonCredit.fromJson(Map<String, dynamic> json) {
    return PersonCredit(id: json['id'] as int, name: json['name'] as String);
  }
}
