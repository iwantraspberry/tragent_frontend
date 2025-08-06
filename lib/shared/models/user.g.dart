// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  avatar: json['avatar'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
  preferences: json['preferences'] == null
      ? null
      : UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'avatar': instance.avatar,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
  'preferences': instance.preferences,
};

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      currency: json['currency'] as String,
      language: json['language'] as String,
      preferredDestinations: json['preferredDestinations'] as String?,
      budgetRange: (json['budgetRange'] as num?)?.toDouble(),
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'language': instance.language,
      'preferredDestinations': instance.preferredDestinations,
      'budgetRange': instance.budgetRange,
      'interests': instance.interests,
    };
