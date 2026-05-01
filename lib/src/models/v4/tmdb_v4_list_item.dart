import '../media_models.dart';

/// [TmdbListV4Item] represents a single item in a v4 list with optional comment.
class TmdbListV4Item {
  final dynamic media; // MovieSummary or TvSummary
  final String mediaType;
  final String? comment;

  TmdbListV4Item({
    required this.media,
    required this.mediaType,
    this.comment,
  });

  factory TmdbListV4Item.fromJson(Map<String, dynamic> json) {
    final type = json['media_type'] as String;
    dynamic media;
    if (type == 'movie') {
      media = MovieSummary.fromJson(json);
    } else if (type == 'tv') {
      media = TvSummary.fromJson(json);
    } else {
      media = json;
    }

    return TmdbListV4Item(
      media: media,
      mediaType: type,
      comment: json['comment'] as String?,
    );
  }
}
