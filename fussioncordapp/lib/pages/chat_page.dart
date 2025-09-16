import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../main.dart' show FussionColors;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'Taro',
      message: 'Hey everyone! I just pushed a new commit to the repo ✨',
      time: '10:30 AM',
      isCurrentUser: false,
    ),
    ChatMessage(
      sender: 'Yuki',
      message: 'Nice! What did you change?',
      time: '10:32 AM',
      isCurrentUser: false,
    ),
    ChatMessage(
      sender: 'Taro',
      message: 'Fixed that annoying bug in the authentication flow',
      time: '10:33 AM',
      isCurrentUser: false,
    ),
    ChatMessage(
      sender: 'You',
      message: 'Great work! I was struggling with that one.',
      time: '10:35 AM',
      isCurrentUser: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Channel header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: FussionColors.surface,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.tag, size: 18),
              const SizedBox(width: 8),
              Text(
                'general',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 8),
              Text(
                '- General discussion for the team',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        
        // Messages list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return MessageBubble(message: message);
            },
          ),
        ),
        
        // Message input
        Container(
          padding: const EdgeInsets.all(8),
          color: FussionColors.surface,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Message #general',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: FussionColors.background,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.code),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: FussionColors.primary,
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    setState(() {
                      _messages.add(
                        ChatMessage(
                          sender: 'You',
                          message: _messageController.text,
                          time: '${DateTime.now().hour}:${DateTime.now().minute}',
                          isCurrentUser: true,
                        ),
                      );
                      _messageController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isCurrentUser) ...[
            CircleAvatar(
              backgroundColor: FussionColors.secondary,
              child: Text(
                message.sender[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: message.isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: message.isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      message.sender,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      message.time,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isCurrentUser
                        ? FussionColors.primary
                        : FussionColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(message.message),
                ),
              ],
            ),
          ),
          if (message.isCurrentUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: FussionColors.accent,
              child: Text(
                message.sender[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}