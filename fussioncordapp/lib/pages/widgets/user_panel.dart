import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../user_profile_page.dart';

class UserPanel extends StatelessWidget {
  final User currentUser;

  const UserPanel({
    super.key,
    required this.currentUser,
  });

  void _showUserProfile(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => UserProfilePage(
        user: currentUser,
        onUserUpdated: (User updatedUser) {
          // Handle user update if needed
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUserProfile(context),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF292B2F), // Discord user panel color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // User avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(currentUser.avatarUrl),
                  onBackgroundImageError: (_, __) {},
                  child: null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getStatusColor(currentUser.status),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF292B2F), // Discord user panel color
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            
            // Username and discriminator
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentUser.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '#${currentUser.discriminator}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB9BBBE), // Discord text secondary color
                    ),
                  ),
                ],
              ),
            ),
            
            // User controls
            IconButton(
              icon: const Icon(Icons.mic, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.headset, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.settings, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => _showUserProfile(context),
              tooltip: 'User Settings',
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.idle:
        return Colors.orange;
      case UserStatus.doNotDisturb:
        return Colors.red;
      case UserStatus.invisible:
      case UserStatus.offline:
        return Colors.grey;
    }
  }
}