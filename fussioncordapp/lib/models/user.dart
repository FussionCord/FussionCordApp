enum UserStatus {
  online,
  idle,
  doNotDisturb,
  invisible,
  offline,
}

class User {
  final String id;
  final String username;
  final String discriminator; // The #0000 part
  final String avatarUrl;
  final String? bannerUrl;
  final UserStatus status;
  final String? customStatus;
  final String? about;
  final List<String>? badges;
  final DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.discriminator,
    required this.avatarUrl,
    this.bannerUrl,
    required this.status,
    this.customStatus,
    this.about,
    this.badges,
    required this.createdAt,
  });
}