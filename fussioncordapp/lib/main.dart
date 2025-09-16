import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/discord_home_page.dart';
import 'pages/loading_screen.dart';
import 'pages/signup_page.dart';
import 'providers/app_providers.dart';

void main() {
  runApp(const ProviderScope(child: FussionCordApp()));
}

class FussionColors {
  // Primary brand colors
  static const Color primary = Color(0xFF5865F2);      // Discord blurple
  static const Color secondary = Color(0xFF3BA55C);    // Discord green
  static const Color danger = Color(0xFFED4245);       // Discord red
  static const Color warning = Color(0xFFFAA61A);      // Warning color
  
  // Background colors
  static const Color background = Color(0xFF36393F);   // Discord dark
  static const Color secondaryBackground = Color(0xFF2F3136); // Discord sidebar
  static const Color tertiaryBackground = Color(0xFF202225); // Discord server list
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);  // White text
  static const Color textSecondary = Color(0xFFB9BBBE); // Discord secondary text
  static const Color textMuted = Color(0xFF72767D);    // Muted text color
  
  // UI element colors
  static const Color inputBackground = Color(0xFF40444B); // Message input background
  static const Color serverList = Color(0xFF202225);   // Discord server list
  static const Color channelList = Color(0xFF2F3136);  // Discord channel list
  static const Color channelSelected = Color(0xFF42464D); // Selected channel
  static const Color userPanel = Color(0xFF292B2F);    // User panel background
  static const Color chatBackground = Color(0xFF36393F); // Chat background
}

class FussionCordApp extends StatefulWidget {
  const FussionCordApp({super.key});

  @override
  State<FussionCordApp> createState() => _FussionCordAppState();
}

class _FussionCordAppState extends State<FussionCordApp> {
  bool _showSignup = true;
  
  void _completeSignup() {
    setState(() {
      _showSignup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FussionCord',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: FussionColors.primary,
          secondary: FussionColors.secondary,
          surface: FussionColors.secondaryBackground,
          background: FussionColors.background,
          error: FussionColors.danger,
          onPrimary: FussionColors.textPrimary,
          onSecondary: FussionColors.textPrimary,
          onSurface: FussionColors.textPrimary,
          onError: FussionColors.textPrimary,
        ),
        scaffoldBackgroundColor: FussionColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: FussionColors.background,
          foregroundColor: FussionColors.textPrimary,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: FussionColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: FussionColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: FussionColors.textPrimary),
          bodyMedium: TextStyle(color: FussionColors.textSecondary),
        ),
        iconTheme: const IconThemeData(
          color: FussionColors.textSecondary,
        ),
        fontFamily: 'Whitney',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: FussionColors.inputBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: FussionColors.primary, width: 2),
          ),
        ),
      ),
      home: LoadingScreen(
        child: _showSignup 
          ? SignupPage(onSignupComplete: _completeSignup)
          : const DiscordHomePage(),
      ),
    );
  }
}
