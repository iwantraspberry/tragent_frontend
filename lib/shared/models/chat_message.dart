import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isFromUser;
  final MessageStatus status;
  final Map<String, dynamic>? metadata;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.isFromUser,
    required this.status,
    this.metadata,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => 
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

enum MessageType {
  text,
  travelPlan,
  destination,
  activity,
  image,
  location
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  error
}

@JsonSerializable()
class ChatSession {
  final String id;
  final String title;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isActive;

  const ChatSession({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.lastUpdated,
    required this.isActive,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) => 
      _$ChatSessionFromJson(json);
  Map<String, dynamic> toJson() => _$ChatSessionToJson(this);
}
