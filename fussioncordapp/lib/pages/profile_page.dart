import 'package:flutter/material.dart';
import '../main.dart' show FussionColors;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: FussionColors.accent,
                  child: Text(
                    'D',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'DevUser',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '@devuser',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Flutter developer & open source contributor',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FussionColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.settings),
                      label: const Text('Settings'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Stats section
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatCard(
                icon: Icons.code_rounded,
                value: '42',
                label: 'Repositories',
              ),
              StatCard(
                icon: Icons.people,
                value: '128',
                label: 'Followers',
              ),
              StatCard(
                icon: Icons.star,
                value: '356',
                label: 'Stars',
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Recent activity
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const ActivityItem(
            icon: Icons.commit,
            title: 'Pushed 3 commits to FussionCord/app',
            description: 'Updated theme colors and implemented chat UI',
            time: '2 hours ago',
          ),
          const Divider(),
          const ActivityItem(
            icon: Icons.comment,
            title: 'Commented on issue #42',
            description: 'Added suggestions for improving the navigation flow',
            time: '5 hours ago',
          ),
          const Divider(),
          const ActivityItem(
            icon: Icons.merge_type,
            title: 'Merged pull request #28',
            description: 'Add code snippet highlighting feature',
            time: '1 day ago',
          ),
          
          const SizedBox(height: 32),
          
          // Projects section
          Text(
            'Your Projects',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const ProjectCard(
            name: 'FussionCord App',
            description: 'Flutter-powered front-end for the FussionCord platform',
            progress: 0.65,
          ),
          const SizedBox(height: 12),
          const ProjectCard(
            name: 'OpenDevin Integration',
            description: 'AI assistant integration for code completion and review',
            progress: 0.32,
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Icon(icon, color: FussionColors.accent, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: FussionColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: FussionColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String name;
  final String description;
  final double progress;

  const ProjectCard({
    super.key,
    required this.name,
    required this.description,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.folder, color: FussionColors.accent),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      color: FussionColors.accent,
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text('${(progress * 100).toInt()}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}