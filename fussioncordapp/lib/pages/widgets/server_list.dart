import 'package:flutter/material.dart';
import '../../main.dart' show FussionColors;
import '../../models/server.dart';
import '../../models/user.dart';

class ServerList extends StatelessWidget {
  final List<Server> servers;
  final Server currentServer;
  final Function(Server) onServerSelected;
  final User currentUser;
  final VoidCallback? onAddServerPressed;

  const ServerList({
    super.key,
    required this.servers,
    required this.currentServer,
    required this.onServerSelected,
    required this.currentUser,
    this.onAddServerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      color: FussionColors.serverList,
      child: Column(
        children: [
          // Home button
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ServerIcon(
              isHome: true,
              isSelected: false,
              onTap: () {},
              iconUrl: null,
              name: 'Home',
            ),
          ),
          
          // Server list divider
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(height: 1, color: Colors.grey),
          ),
          
          // Server list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: servers.length,
              itemBuilder: (context, index) {
                final server = servers[index];
                return ServerIcon(
                  isHome: false,
                  isSelected: server.id == currentServer.id,
                  onTap: () => onServerSelected(server),
                  iconUrl: server.iconUrl,
                  name: server.name,
                );
              },
            ),
          ),
          
          // Add server button with animation
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: FussionColors.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: FussionColors.secondaryBackground,
              child: IconButton(
                icon: const Icon(Icons.add, color: FussionColors.secondary),
                onPressed: () {
                  if (onAddServerPressed != null) {
                    onAddServerPressed!();
                  }
                },
                tooltip: 'Add Server',
              ),
            ),
          ),
          
          // Explore button with animation
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: FussionColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: FussionColors.secondaryBackground,
              child: IconButton(
                icon: const Icon(Icons.explore, color: FussionColors.secondary),
                onPressed: () {},
                tooltip: 'Explore Servers',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServerIcon extends StatelessWidget {
  final bool isHome;
  final bool isSelected;
  final VoidCallback onTap;
  final String? iconUrl;
  final String name;
  final Color? customColor;

  const ServerIcon({
    super.key,
    required this.isHome,
    required this.isSelected,
    required this.onTap,
    required this.iconUrl,
    required this.name,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Selection indicator
          if (isSelected)
            Container(
              height: 40,
              width: 4,
              decoration: BoxDecoration(
                color: customColor ?? FussionColors.primary,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: (customColor ?? FussionColors.primary).withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  )
                ],
              ),
            ),
          
          // Server icon
          Center(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(isSelected ? 16 : 24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 48,
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isHome ? FussionColors.primary : FussionColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(isSelected ? 16 : 24),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: (customColor ?? FussionColors.primary).withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    )
                  ] : null,
                ),
                child: Center(
                  child: isHome
                      ? Icon(Icons.discord, color: Colors.white, size: 28, 
                          shadows: [Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 2)])
                      : iconUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(isSelected ? 16 : 24),
                              child: Image.network(
                                iconUrl!,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          FussionColors.primary,
                                          FussionColors.primary.withBlue(255),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        name.substring(0, 1).toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    FussionColors.primary,
                                    FussionColors.primary.withBlue(255),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  name.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    shadows: [Shadow(color: Colors.black26, blurRadius: 2, offset: Offset(1, 1))],
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}