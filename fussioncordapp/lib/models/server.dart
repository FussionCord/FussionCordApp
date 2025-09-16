import 'package:flutter/material.dart';
import 'channel.dart';
import 'user.dart';

class Server {
  final String id;
  final String name;
  final String? iconUrl;
  final String? bannerUrl;
  final String ownerId;
  final List<Channel> channels;
  final List<ServerRole> roles;
  final List<ServerMember> members;
  final bool isPrivate;

  Server({
    required this.id,
    required this.name,
    this.iconUrl,
    this.bannerUrl,
    required this.ownerId,
    required this.channels,
    required this.roles,
    required this.members,
    this.isPrivate = false,
  });

  // Factory constructor to create a server with default channels
  factory Server.create({
    required String id,
    required String name,
    required String ownerId,
    String? iconUrl,
    String? bannerUrl,
    bool isPrivate = false,
  }) {
    // Create default roles
    final List<ServerRole> defaultRoles = [
      ServerRole(
        id: '1',
        name: 'Admin',
        color: Colors.red,
        permissions: [
          Permission.administrator,
          Permission.manageServer,
          Permission.manageChannels,
          Permission.manageRoles,
        ],
        position: 1,
      ),
      ServerRole(
        id: '2',
        name: 'Moderator',
        color: Colors.blue,
        permissions: [
          Permission.manageMessages,
          Permission.kickMembers,
          Permission.banMembers,
        ],
        position: 2,
      ),
      ServerRole(
        id: '3',
        name: 'Member',
        color: Colors.green,
        permissions: [
          Permission.sendMessages,
          Permission.readMessages,
          Permission.addReactions,
        ],
        position: 3,
      ),
    ];

    // Create default channels
    final List<Channel> defaultChannels = [
      Channel(
        id: '1',
        name: 'welcome',
        type: ChannelType.text,
        serverId: id,
        position: 0,
        isPrivate: false,
      ),
      Channel(
        id: '2',
        name: 'general',
        type: ChannelType.text,
        serverId: id,
        position: 1,
        isPrivate: false,
      ),
      Channel(
        id: '3',
        name: 'announcements',
        type: ChannelType.text,
        serverId: id,
        position: 2,
        isPrivate: false,
      ),
      Channel(
        id: '4',
        name: 'General',
        type: ChannelType.voice,
        serverId: id,
        position: 3,
        isPrivate: false,
      ),
    ];

    // Create owner as a member
    final List<ServerMember> defaultMembers = [
      ServerMember(
        userId: ownerId,
        serverId: id,
        nickname: null,
        joinedAt: DateTime.now(),
        roleIds: ['1'], // Admin role
      ),
    ];

    return Server(
      id: id,
      name: name,
      iconUrl: iconUrl,
      bannerUrl: bannerUrl,
      ownerId: ownerId,
      channels: defaultChannels,
      roles: defaultRoles,
      members: defaultMembers,
      isPrivate: isPrivate,
    );
  }
}

class ServerRole {
  final String id;
  final String name;
  final Color color;
  final List<Permission> permissions;
  final int position;
  final String? iconUrl;

  ServerRole({
    required this.id,
    required this.name,
    required this.color,
    required this.permissions,
    required this.position,
    this.iconUrl,
  });
}

class ServerMember {
  final String userId;
  final String serverId;
  final String? nickname;
  final DateTime joinedAt;
  final List<String> roleIds;

  ServerMember({
    required this.userId,
    required this.serverId,
    this.nickname,
    required this.joinedAt,
    required this.roleIds,
  });
}

enum Permission {
  administrator,
  manageServer,
  manageChannels,
  manageRoles,
  manageMessages,
  kickMembers,
  banMembers,
  sendMessages,
  readMessages,
  addReactions,
}