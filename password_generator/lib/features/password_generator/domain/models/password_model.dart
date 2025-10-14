class PasswordModel {
  final String password;
  final String? nickname;
  final DateTime createdAt;

  PasswordModel({
    required this.password,
    this.nickname,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  PasswordModel copyWith({
    String? password,
    String? nickname,
  }) {
    return PasswordModel(
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      createdAt: createdAt,
    );
  }
}