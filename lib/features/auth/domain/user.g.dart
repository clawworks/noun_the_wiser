// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  isAnonymous: json['isAnonymous'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastSeen: DateTime.parse(json['lastSeen'] as String),
  isOnline: json['isOnline'] as bool? ?? false,
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isAnonymous': instance.isAnonymous,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastSeen': instance.lastSeen.toIso8601String(),
      'isOnline': instance.isOnline,
    };
