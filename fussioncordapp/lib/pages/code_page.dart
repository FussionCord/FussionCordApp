import 'package:flutter/material.dart';
import '../main.dart' show FussionColors;

class CodePage extends StatelessWidget {
  const CodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code Repositories',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          
          // Repository list
          Expanded(
            child: ListView(
              children: const [
                RepositoryCard(
                  name: 'FussionCord/app',
                  description: 'The Flutter-powered front-end of the FussionCord ecosystem',
                  language: 'Dart',
                  stars: 42,
                  forks: 12,
                ),
                SizedBox(height: 12),
                RepositoryCard(
                  name: 'FussionCord/backend',
                  description: 'Golang API server for FussionCord',
                  language: 'Go',
                  stars: 38,
                  forks: 8,
                ),
                SizedBox(height: 12),
                RepositoryCard(
                  name: 'FussionCord/opendevin',
                  description: 'AI coding assistant integration for FussionCord',
                  language: 'Python',
                  stars: 128,
                  forks: 24,
                ),
              ],
            ),
          ),
          
          // Code snippet section
          const SizedBox(height: 24),
          Text(
            'Recent Code Snippets',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          const CodeSnippet(
            title: 'Flutter Theme Implementation',
            code: '''
// Define FussionCord color palette
class FussionColors {
  static const Color primary = Color(0xFF6E56CF);
  static const Color secondary = Color(0xFFEF8354);
  static const Color background = Color(0xFF1E1E2E);
  static const Color surface = Color(0xFF2A2A3C);
  static const Color textPrimary = Color(0xFFF1F1F3);
  static const Color textSecondary = Color(0xFFB8B8C0);
  static const Color accent = Color(0xFFFF8FAB);
}''',
            language: 'dart',
            author: 'Yuki',
            timestamp: '2 hours ago',
          ),
        ],
      ),
    );
  }
}

class RepositoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String language;
  final int stars;
  final int forks;

  const RepositoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.forks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.book, color: FussionColors.accent),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: FussionColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _getLanguageColor(language),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(language),
                const SizedBox(width: 16),
                const Icon(Icons.star_border, size: 16),
                const SizedBox(width: 4),
                Text('$stars'),
                const SizedBox(width: 16),
                const Icon(Icons.fork_right, size: 16),
                const SizedBox(width: 4),
                Text('$forks'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Colors.blue;
      case 'go':
        return Colors.teal;
      case 'python':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}

class CodeSnippet extends StatelessWidget {
  final String title;
  final String code;
  final String language;
  final String author;
  final String timestamp;

  const CodeSnippet({
    super.key,
    required this.title,
    required this.code,
    required this.language,
    required this.author,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'by $author',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 8),
                Text(
                  timestamp,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: FussionColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text('Copy'),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: const Icon(Icons.comment_outlined, size: 16),
                  label: const Text('Comment'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}