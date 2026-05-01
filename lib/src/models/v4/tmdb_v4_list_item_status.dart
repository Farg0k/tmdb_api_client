class TmdbListV4ItemStatus {
  final int mediaId;
  final String mediaType;
  final bool success;
  final String? comment;

  TmdbListV4ItemStatus({
    required this.mediaId,
    required this.mediaType,
    required this.success,
    this.comment,
  });

  factory TmdbListV4ItemStatus.fromJson(Map<String, dynamic> json) {
    return TmdbListV4ItemStatus(
      mediaId: json['media_id'] as int,
      mediaType: json['media_type'] as String,
      success: json['success'] as bool,
      comment: json['comment'] as String?,
    );
  }
}
