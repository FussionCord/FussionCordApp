import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';

// Navigation state provider
final selectedTabProvider = StateProvider<int>((ref) => 0);

// Chat messages provider
final chatMessagesProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier();
});

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier() : super([
    ChatMessage(
      id: '1',
      content: 'Hey everyone! I just pushed a new commit to the repo ✨',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      senderId: 'user1',
      senderName: 'Taro',
      senderAvatarUrl: 'https://i.pravatar.cc/150?img=1',
      isCurrentUser: false,
      channelId: 'general',
    ),
    ChatMessage(
      id: '2',
      content: 'Nice! What did you change?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 58)),
      senderId: 'user2',
      senderName: 'Yuki',
      senderAvatarUrl: 'https://i.pravatar.cc/150?img=2',
      isCurrentUser: false,
      channelId: 'general',
    ),
    ChatMessage(
      id: '3',
      content: 'Fixed that annoying bug in the authentication flow',
      timestamp: DateTime.now().subtract(const Duration(minutes: 57)),
      senderId: 'user1',
      senderName: 'Taro',
      senderAvatarUrl: 'https://i.pravatar.cc/150?img=1',
      isCurrentUser: false,
      channelId: 'general',
    ),
    ChatMessage(
      id: '4',
      content: 'Great work! I was struggling with that one.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
      senderId: 'currentUser',
      senderName: 'You',
      senderAvatarUrl: 'https://i.pravatar.cc/150?img=3',
      isCurrentUser: true,
      channelId: 'general',
    ),
  ]);

  void addMessage(String message) {
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      timestamp: DateTime.now(),
      senderId: 'currentUser',
      senderName: 'You',
      senderAvatarUrl: 'https://i.pravatar.cc/150?img=3',
      isCurrentUser: true,
      channelId: 'general',
    );
    
    state = [...state, newMessage];
  }
}