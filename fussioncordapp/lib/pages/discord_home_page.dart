import 'package:flutter/material.dart';
import '../main.dart' show FussionColors;
import '../models/server.dart';
import '../models/channel.dart';
import '../models/user.dart';
import 'widgets/server_list.dart';
import 'widgets/channel_sidebar.dart';
import 'widgets/discord_chat_view.dart';
import 'widgets/custom_app_bar.dart';
import 'server_creation_page.dart';

class DiscordHomePage extends StatefulWidget {
  const DiscordHomePage({super.key});

  @override
  State<DiscordHomePage> createState() => _DiscordHomePageState();
}

class _DiscordHomePageState extends State<DiscordHomePage> {
  // Mock data for demonstration
  final currentUser = User(
    id: 'user1',
    username: 'FussionUser',
    discriminator: '0001',
    avatarUrl: 'https://i.pravatar.cc/150?img=1',
    status: UserStatus.online,
    createdAt: DateTime.now().subtract(const Duration(days: 365)),
  );

  late List<Server> servers;
  late Server currentServer;
  late Channel currentChannel;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize mock servers
    servers = [
      Server.create(
        id: 'server1',
        name: 'FussionCord HQ',
        ownerId: currentUser.id,
        iconUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      Server.create(
        id: 'server2',
        name: 'Gaming Squad',
        ownerId: currentUser.id,
        iconUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      Server.create(
        id: 'server3',
        name: 'Study Group',
        ownerId: currentUser.id,
        iconUrl: 'https://i.pravatar.cc/150?img=4',
      ),
    ];
    
    // Set initial server and channel
    currentServer = servers[0];
    currentChannel = currentServer.channels[1]; // general channel
  }
  
  void changeServer(Server server) {
    setState(() {
      currentServer = server;
      currentChannel = server.channels[1]; // Default to general
    });
  }
  
  void _showServerCreationDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => ServerCreationPage(
        onServerCreated: (newServer) {
          setState(() {
            // Create a new server with the required structure
            final newServerObj = Server(
              id: newServer['id'],
              name: newServer['name'],
              iconUrl: newServer['icon'],
              ownerId: currentUser.id,
              channels: [],
              roles: [],
              members: [],
            );
            servers.add(newServerObj);
            currentServer = newServerObj;
            currentChannel = newServerObj.channels[0];
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }
  
  void changeChannel(Channel channel) {
    setState(() {
      currentChannel = channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: currentServer.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: FussionColors.textSecondary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: FussionColors.textSecondary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: FussionColors.primary.withOpacity(0.2),
            child: Text(
              currentUser.username.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: FussionColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              FussionColors.background,
              FussionColors.tertiaryBackground.withOpacity(0.9),
            ],
          ),
        ),
        child: Row(
          children: [
            // Server list (left sidebar)
            Container(
              decoration: BoxDecoration(
                color: FussionColors.tertiaryBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: ServerList(
                servers: servers,
                currentServer: currentServer,
                onServerSelected: changeServer,
                currentUser: currentUser,
                onAddServerPressed: _showServerCreationDialog,
              ),
            ),
            
            // Channel sidebar
            Container(
              decoration: BoxDecoration(
                color: FussionColors.secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(1, 0),
                  ),
                ],
              ),
              child: ChannelSidebar(
                server: currentServer,
                currentChannel: currentChannel,
                currentUser: currentUser,
                onChannelSelected: changeChannel,
              ),
            ),
            
            // Chat area (main content)
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                ),
                child: DiscordChatView(
                  channel: currentChannel,
                  currentUser: currentUser,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}