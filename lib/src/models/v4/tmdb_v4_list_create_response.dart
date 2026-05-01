/// [TmdbListV4CreateResponse] represents the response when creating a new v4 list.
class TmdbListV4CreateResponse {
  final bool success;
  final int id;
  final int statusCode;
  final String statusMessage;

  TmdbListV4CreateResponse({
    required this.success,
    required this.id,
    required this.statusCode,
    required this.statusMessage,
  });

  factory TmdbListV4CreateResponse.fromJson(Map<String, dynamic> json) {
    return TmdbListV4CreateResponse(
      success: json['success'] as bool,
      id: json['id'] as int,
      statusCode: json['status_code'] as int,
      statusMessage: json['status_message'] as String,
    );
  }
}
