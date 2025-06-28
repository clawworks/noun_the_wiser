import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    String? email,
    @Default(true) bool isAnonymous,
    required DateTime createdAt,
    required DateTime lastSeen,
    @Default(false) bool isOnline,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.create({
    required String name,
    String? email,
    bool isAnonymous = true,
  }) {
    final now = DateTime.now();
    return User(
      id:
          now.millisecondsSinceEpoch
              .toString(), // Will be replaced with proper ID generation
      name: name,
      email: email,
      isAnonymous: isAnonymous,
      createdAt: now,
      lastSeen: now,
      isOnline: true,
    );
  }
}
