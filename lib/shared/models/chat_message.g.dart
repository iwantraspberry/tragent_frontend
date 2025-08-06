// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
  id: json['id'] as String,
  content: json['content'] as String,
  type: $enumDecode(_$MessageTypeEnumMap, json['type']),
  timestamp: DateTime.parse(json['timestamp'] as String),
  isFromUser: json['isFromUser'] as bool,
  status: $enumDecode(_$MessageStatusEnumMap, json['status']),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'isFromUser': instance.isFromUser,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'metadata': instance.metadata,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.travelPlan: 'travelPlan',
  MessageType.destination: 'destination',
  MessageType.activity: 'activity',
  MessageType.image: 'image',
  MessageType.location: 'location',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.error: 'error',
};

ChatSession _$ChatSessionFromJson(Map<String, dynamic> json) => ChatSession(
  id: json['id'] as String,
  title: json['title'] as String,
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$ChatSessionToJson(ChatSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'messages': instance.messages,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'isActive': instance.isActive,
    };
