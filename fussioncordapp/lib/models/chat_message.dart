class ChatMessage {
  final String id;
  final String content;
  final DateTime timestamp;
  final String senderId;
  final String senderName;
  final String? senderAvatarUrl;
  final List<Reaction> reactions;
  final List<Attachment>? attachments;
  final bool isCurrentUser;
  final bool isPinned;
  final String channelId;
  final String? replyToMessageId;

  ChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    this.reactions = const [],
    this.attachments,
    required this.isCurrentUser,
    this.isPinned = false,
    required this.channelId,
    this.replyToMessageId,
  });
}

class Reaction {
  final String emoji;
  final int count;
  final List<String> userIds;
  
  Reaction({
    required this.emoji,
    required this.count,
    required this.userIds,
  });
}

class Attachment {
  final String id;
  final String url;
  final String filename;
  final int size;
  final String? contentType;
  final int? width;
  final int? height;
  
  Attachment({
    required this.id,
    required this.url,
    required this.filename,
    required this.size,
    this.contentType,
    this.width,
    this.height,
  });
}