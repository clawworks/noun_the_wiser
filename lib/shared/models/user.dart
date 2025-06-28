class User {
  final String id;
  final String name;
  final String? email;
  final bool isAnonymous;
  final DateTime createdAt;
  final DateTime lastSeen;
  final bool isOnline;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.isAnonymous = true,
    required this.createdAt,
    required this.lastSeen,
    this.isOnline = false,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAnonymous,
    DateTime? createdAt,
    DateTime? lastSeen,
    bool? isOnline,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAnonymous': isAnonymous,
      'createdAt': createdAt.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'isOnline': isOnline,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, name: $name, isOnline: $isOnline)';
  }
}
