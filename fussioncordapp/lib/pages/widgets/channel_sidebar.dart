import 'package:flutter/material.dart';
import '../../main.dart' show FussionColors;
import '../../models/server.dart';
import '../../models/channel.dart';
import '../../models/user.dart';
import 'user_panel.dart';

class ChannelSidebar extends StatelessWidget {
  final Server server;
  final Channel currentChannel;
  final Function(Channel) onChannelSelected;
  final User currentUser;

  const ChannelSidebar({
    super.key,
    required this.server,
    required this.currentChannel,
    required this.onChannelSelected,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Column(
        children: [
          // Server header
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  FussionColors.secondaryBackground,
                  FussionColors.secondaryBackground.withOpacity(0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: FussionColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: server.iconUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            server.iconUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  server.name.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: FussionColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            server.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: FussionColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    server.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FussionColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_drop_down, size: 20),
                    onPressed: () {},
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    color: FussionColors.primary,
                  ),
                ),
              ],
            ),
          ),
          
          // Channel list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Group channels by category
                ...buildChannelCategories(),
              ],
            ),
          ),
          
          // User panel
          UserPanel(currentUser: currentUser),
        ],
      ),
    );
  }

  List<Widget> buildChannelCategories() {
    // Group channels by category
    final Map<String?, List<Channel>> categorizedChannels = {};
    
    for (final channel in server.channels) {
      if (channel.type == ChannelType.category) continue;
      
      final categoryId = channel.parentId;
      if (!categorizedChannels.containsKey(categoryId)) {
        categorizedChannels[categoryId] = [];
      }
      categorizedChannels[categoryId]!.add(channel);
    }
    
    final List<Widget> widgets = [];
    
    // Add uncategorized channels first
    if (categorizedChannels.containsKey(null)) {
      for (final channel in categorizedChannels[null]!) {
        widgets.add(ChannelTile(
          channel: channel,
          isSelected: channel.id == currentChannel.id,
          onTap: () => onChannelSelected(channel),
        ));
      }
      widgets.add(const SizedBox(height: 16));
    }
    
    // Add categorized channels
    for (final category in server.channels.where((c) => c.type == ChannelType.category)) {
      widgets.add(CategoryHeader(name: category.name));
      
      if (categorizedChannels.containsKey(category.id)) {
        for (final channel in categorizedChannels[category.id]!) {
          widgets.add(ChannelTile(
            channel: channel,
            isSelected: channel.id == currentChannel.id,
            onTap: () => onChannelSelected(channel),
          ));
        }
      }
      
      widgets.add(const SizedBox(height: 16));
    }
    
    return widgets;
  }
}

class CategoryHeader extends StatelessWidget {
  final String name;

  const CategoryHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 4),
      child: Row(
        children: [
          Icon(
            Icons.expand_more,
            size: 12,
            color: FussionColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: FussionColors.textSecondary,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.add,
            size: 16,
            color: FussionColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class ChannelTile extends StatelessWidget {
  final Channel channel;
  final bool isSelected;
  final VoidCallback onTap;

  const ChannelTile({
    super.key,
    required this.channel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final IconData iconData;
    switch (channel.type) {
      case ChannelType.text:
        iconData = Icons.tag;
        break;
      case ChannelType.voice:
        iconData = Icons.volume_up;
        break;
      case ChannelType.announcement:
        iconData = Icons.campaign;
        break;
      default:
        iconData = Icons.tag;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        decoration: BoxDecoration(
          color: isSelected ? FussionColors.channelSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 20,
              color: isSelected 
                  ? FussionColors.textPrimary 
                  : FussionColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                channel.name,
                style: TextStyle(
                  color: isSelected 
                      ? FussionColors.textPrimary 
                      : FussionColors.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (channel.type == ChannelType.voice)
              Icon(
                Icons.headset,
                size: 16,
                color: FussionColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }
}