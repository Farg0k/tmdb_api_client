/// [AccountDetails] represents the response structure for the user's account details
/// from the TMDB API's `/account` endpoint.
/// This endpoint requires a valid `session_id`.
class AccountDetails {
  final String avatarPath; // The path to the user's avatar image.
  final int id; // The user's account ID.
  final String name; // The user's name.
  final String username; // The user's username.

  /// Constructor for [AccountDetails].
  AccountDetails({
    required this.avatarPath,
    required this.id,
    required this.name,
    required this.username,
  });

  /// Factory constructor to create an [AccountDetails] instance from a JSON map.
  /// This is commonly used when parsing API responses.
  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    // TMDB's account details response is a bit nested for avatar.
    final avatarJson = json['avatar'] as Map<String, dynamic>?;
    final gravatar = avatarJson?['gravatar'] as Map<String, dynamic>?;

    return AccountDetails(
      avatarPath: gravatar?['hash'] as String? ?? '', // Gravatar hash is used to construct the avatar URL.
      id: json['id'] as int, // User's account ID.
      name: json['name'] as String? ?? 'N/A', // User's name, can be null on TMDB.
      username: json['username'] as String, // User's username.
    );
  }

  /// Helper getter to construct the full Gravatar URL for the user's avatar.
  /// Returns null if `avatarPath` is empty.
  String? get fullGravatarUrl {
    return avatarPath.isNotEmpty
        ? 'https://www.gravatar.com/avatar/$avatarPath?s=200' // 's=200' for a 200x200 pixel image.
        : null;
  }
}