import 'chat_message.dart';

class Thread {
  final String id;
  final String name;
  final String channelId;
  final String parentMessageId;
  final DateTime createdAt;
  final String createdById;
  final List<ChatMessage> messages;
  final bool isArchived;
  final DateTime? archivedAt;

  Thread({
    required this.id,
    required this.name,
    required this.channelId,
    required this.parentMessageId,
    required this.createdAt,
    required this.createdById,
    required this.messages,
    this.isArchived = false,
    this.archivedAt,
  });
}