import 'chat_message.dart';
import 'thread.dart';

enum ChannelType {
  text,
  voice,
  category,
  announcement,
  forum,
}

class Channel {
  final String id;
  final String name;
  final ChannelType type;
  final String serverId;
  final String? parentId; // For nested channels under categories
  final String? topic;
  final int position;
  final bool isPrivate;
  final List<String>? allowedRoleIds;
  final List<String>? allowedUserIds;
  final List<ChatMessage>? messages;
  final List<Thread>? threads;

  Channel({
    required this.id,
    required this.name,
    required this.type,
    required this.serverId,
    this.parentId,
    this.topic,
    required this.position,
    required this.isPrivate,
    this.allowedRoleIds,
    this.allowedUserIds,
    this.messages,
    this.threads,
  });
}