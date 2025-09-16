import 'package:flutter/material.dart';
import '../models/user.dart';
import '../main.dart' show FussionColors;

class UserProfilePage extends StatefulWidget {
  final User user;
  final Function(User) onUserUpdated;
  
  const UserProfilePage({
    Key? key, 
    required this.user,
    required this.onUserUpdated,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  late TextEditingController _usernameController;
  late TextEditingController _statusController;
  late TextEditingController _bioController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isEditing = false;
  bool _isSaving = false;
  Color _selectedAccentColor = Colors.purple; // Default accent color
  
  final List<Color> _accentColors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _statusController = TextEditingController(text: widget.user.customStatus ?? '');
    _bioController = TextEditingController(text: widget.user.about ?? '');
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _usernameController.dispose();
    _statusController.dispose();
    _bioController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username cannot be empty')),
      );
      return;
    }
    
    setState(() {
      _isSaving = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    final updatedUser = User(
      id: widget.user.id,
      username: _usernameController.text,
      discriminator: widget.user.discriminator,
      avatarUrl: widget.user.avatarUrl,
      status: widget.user.status,
      customStatus: _statusController.text.isEmpty ? null : _statusController.text,
      about: _bioController.text.isEmpty ? null : _bioController.text,
      createdAt: widget.user.createdAt,
    );
    
    setState(() {
      _isSaving = false;
      _isEditing = false;
    });
    
    widget.onUserUpdated(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  FussionColors.background.withOpacity(0.9),
                  FussionColors.secondaryBackground.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: FussionColors.primary.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (!_isEditing)
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white70),
                            onPressed: () => setState(() => _isEditing = true),
                            tooltip: 'Edit Profile',
                          ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Avatar and username section
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purple.withOpacity(0.2),
                          child: Text(
                            widget.user.username.isNotEmpty 
                                ? widget.user.username[0].toUpperCase() 
                                : '?',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: FussionColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _isEditing
                          ? TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                hintText: 'Enter your username',
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.user.username,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '#${widget.user.discriminator}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Custom Status section
                if (_isEditing)
                  TextFormField(
                    controller: _statusController,
                    decoration: const InputDecoration(
                      labelText: 'Custom Status',
                      hintText: 'What\'s on your mind?',
                      prefixIcon: Icon(Icons.mood),
                      border: OutlineInputBorder(),
                    ),
                  )
                else
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: widget.user.status == UserStatus.online ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.user.customStatus == null || widget.user.customStatus!.isEmpty ? 'No status set' : widget.user.customStatus!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                
                // About section
                if (_isEditing)
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: 'About',
                      hintText: 'Tell us about yourself...',
                      prefixIcon: Icon(Icons.description_outlined),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  )
                else if (widget.user.about != null && widget.user.about!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About me',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.user.about!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                
                // Accent color selection
                if (_isEditing) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Accent Color',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _accentColors.map((color) {
                      return GestureDetector(
                        onTap: () => setState(() => _selectedAccentColor = color),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: color == _selectedAccentColor
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                
                // Save button
                if (_isEditing) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FussionColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Save Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}