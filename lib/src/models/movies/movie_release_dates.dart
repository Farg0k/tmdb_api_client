/// [MovieReleaseDateEntry] represents a release date and certification for a specific country.
class MovieReleaseDateEntry {
  final String iso_3166_1;
  final List<ReleaseDateDetails> releaseDates;

  MovieReleaseDateEntry({required this.iso_3166_1, required this.releaseDates});

  factory MovieReleaseDateEntry.fromJson(Map<String, dynamic> json) {
    return MovieReleaseDateEntry(
      iso_3166_1: json['iso_3166_1'] as String,
      releaseDates: (json['release_dates'] as List)
          .map((i) => ReleaseDateDetails.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReleaseDateDetails {
  final String certification;
  final List<String> descriptors;
  final String iso_639_1;
  final String note;
  final String releaseDate;
  final int type;

  ReleaseDateDetails({
    required this.certification,
    required this.descriptors,
    required this.iso_639_1,
    required this.note,
    required this.releaseDate,
    required this.type,
  });

  factory ReleaseDateDetails.fromJson(Map<String, dynamic> json) {
    return ReleaseDateDetails(
      certification: json['certification'] as String? ?? '',
      descriptors:
          (json['descriptors'] as List?)?.map((e) => e as String).toList() ??
          [],
      iso_639_1: json['iso_639_1'] as String? ?? '',
      note: json['note'] as String? ?? '',
      releaseDate: json['release_date'] as String,
      type: json['type'] as int,
    );
  }
}

class MovieReleaseDatesResponse {
  final int id;
  final List<MovieReleaseDateEntry> results;

  MovieReleaseDatesResponse({required this.id, required this.results});

  factory MovieReleaseDatesResponse.fromJson(Map<String, dynamic> json) {
    return MovieReleaseDatesResponse(
      id: json['id'] as int,
      results: (json['results'] as List)
          .map((i) => MovieReleaseDateEntry.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
