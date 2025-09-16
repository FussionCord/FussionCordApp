import 'package:flutter/material.dart';
import '../../main.dart' show FussionColors;
import '../../models/channel.dart';
import '../../models/user.dart';
import '../../models/chat_message.dart';

class DiscordChatView extends StatefulWidget {
  final Channel channel;
  final User currentUser;

  const DiscordChatView({
    super.key,
    required this.channel,
    required this.currentUser,
  });

  @override
  State<DiscordChatView> createState() => _DiscordChatViewState();
}

class _DiscordChatViewState extends State<DiscordChatView> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // Mock messages for demonstration
    setState(() {
      _messages.addAll([
        ChatMessage(
          id: '1',
          content: 'Welcome to the ${widget.channel.name} channel!',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          senderId: 'system',
          senderName: 'System',
          senderAvatarUrl: 'https://i.pravatar.cc/150?img=0',
          isCurrentUser: false,
          channelId: widget.channel.id,
          reactions: [
            Reaction(emoji: '👋', count: 3, userIds: ['user1', 'user2', 'user3']),
          ],
        ),
        ChatMessage(
          id: '2',
          content: 'Hey everyone! How\'s it going?',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          senderId: 'user2',
          senderName: 'CoolUser',
          senderAvatarUrl: 'https://i.pravatar.cc/150?img=5',
          isCurrentUser: false,
          channelId: widget.channel.id,
          reactions: [
            Reaction(emoji: '👍', count: 2, userIds: ['user1', 'user3']),
          ],
        ),
        ChatMessage(
          id: '3',
          content: 'I\'m working on a new project using Flutter!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          senderId: 'user3',
          senderName: 'FlutterDev',
          senderAvatarUrl: 'https://i.pravatar.cc/150?img=7',
          isCurrentUser: false,
          channelId: widget.channel.id,
          reactions: [],
        ),
        ChatMessage(
          id: '4',
          content: 'That sounds awesome! Can you share some details?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          senderId: widget.currentUser.id,
          senderName: widget.currentUser.username,
          senderAvatarUrl: widget.currentUser.avatarUrl,
          isCurrentUser: true,
          channelId: widget.channel.id,
          reactions: [],
        ),
        ChatMessage(
          id: '5',
          content: 'Sure! I\'m building a Discord-like app with all the features like servers, channels, threads, and more!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          senderId: 'user3',
          senderName: 'FlutterDev',
          senderAvatarUrl: 'https://i.pravatar.cc/150?img=7',
          isCurrentUser: false,
          channelId: widget.channel.id,
          reactions: [
            Reaction(emoji: '🔥', count: 1, userIds: [widget.currentUser.id]),
            Reaction(emoji: '👀', count: 1, userIds: ['user2']),
          ],
        ),
      ]);
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: _messageController.text.trim(),
          timestamp: DateTime.now(),
          senderId: widget.currentUser.id,
          senderName: widget.currentUser.username,
          senderAvatarUrl: widget.currentUser.avatarUrl,
          isCurrentUser: true,
          channelId: widget.channel.id,
          reactions: [],
        ),
      );
      _messageController.clear();
    });

    // Scroll to bottom after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Messages list
        Expanded(
          child: Container(
            color: FussionColors.chatBackground,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isFirstMessageOfGroup = index == 0 ||
                    _messages[index - 1].senderId != message.senderId ||
                    _messages[index].timestamp.difference(_messages[index - 1].timestamp).inMinutes > 5;

                return MessageTile(
                  message: message,
                  showHeader: isFirstMessageOfGroup,
                  currentUser: widget.currentUser,
                );
              },
            ),
          ),
        ),
        
        // Message input
        Container(
          padding: const EdgeInsets.all(16),
          color: FussionColors.chatBackground,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFFB9BBBE)),
                onPressed: () {},
                tooltip: 'Add File',
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF40444B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Message #${widget.channel.name}',
                      hintStyle: const TextStyle(color: Color(0xFFB9BBBE)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.emoji_emotions, color: Color(0xFFB9BBBE)),
                onPressed: () {},
                tooltip: 'Emoji',
              ),
              IconButton(
                icon: const Icon(Icons.gif_box, color: Color(0xFFB9BBBE)),
                onPressed: () {},
                tooltip: 'GIF',
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class MessageTile extends StatelessWidget {
  final ChatMessage message;
  final bool showHeader;
  final User currentUser;

  const MessageTile({
    super.key,
    required this.message,
    required this.showHeader,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            CircleAvatar(
              radius: 20,
              backgroundImage: message.senderAvatarUrl != null ? NetworkImage(message.senderAvatarUrl!) : null,
              onBackgroundImageError: (_, __) {},
              backgroundColor: Colors.grey[800],
              child: null,
            )
          else
            const SizedBox(width: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showHeader)
                  Row(
                    children: [
                      Text(
                        message.senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTimestamp(message.timestamp),
                        style: const TextStyle(
                          color: Color(0xFFB9BBBE),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                if (showHeader) const SizedBox(height: 4),
                Text(
                  message.content,
                  style: const TextStyle(fontSize: 15),
                ),
                if (message.reactions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 8,
                      children: message.reactions.map((reaction) {
                        final bool userReacted = reaction.userIds.contains(currentUser.id);
                        return InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: userReacted
                                  ? const Color(0xFF5865F2).withOpacity(0.3)
                                  : const Color(0xFF40444B),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: userReacted
                                    ? const Color(0xFF5865F2)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(reaction.emoji),
                                const SizedBox(width: 4),
                                Text(
                                  reaction.count.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: userReacted
                                        ? const Color(0xFF5865F2)
                                        : const Color(0xFFB9BBBE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}