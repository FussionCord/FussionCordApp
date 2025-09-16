import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../main.dart';

class LoadingScreen extends StatefulWidget {
  final Widget child;
  
  const LoadingScreen({super.key, required this.child});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showMainApp = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // Simulate loading time
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showMainApp = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showMainApp) {
      return widget.child;
    }
    
    return Scaffold(
      backgroundColor: FussionColors.tertiaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for logo (will be replaced with actual logo)
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: FussionColors.primary.withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: FussionColors.primary.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Animated loading indicator
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: FussionColors.background,
                valueColor: AlwaysStoppedAnimation<Color>(FussionColors.primary),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'FussionCord',
              style: TextStyle(
                color: FussionColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Connecting worlds...',
              style: TextStyle(
                color: FussionColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}