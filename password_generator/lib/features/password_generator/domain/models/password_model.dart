class PasswordModel {
  final String id;
  final String password;
  final String? nickname;
  final DateTime createdAt;
  final DateTime updatedAt;

  PasswordModel({
    String? id,
    required this.password,
    this.nickname,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  PasswordModel copyWith({
    String? password,
    String? nickname,
    DateTime? updatedAt,
  }) {
    return PasswordModel(
      id: id,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'nickname': nickname,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: map['id'],
      password: map['password'],
      nickname: map['nickname'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'PasswordModel(id: $id, password: $password, nickname: $nickname, createdAt: $createdAt)';
  }
}