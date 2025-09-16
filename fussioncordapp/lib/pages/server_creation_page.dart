import 'package:flutter/material.dart';
import '../main.dart' show FussionColors;

class ServerCreationPage extends StatefulWidget {
  final Function onServerCreated;
  
  const ServerCreationPage({Key? key, required this.onServerCreated}) : super(key: key);

  @override
  _ServerCreationPageState createState() => _ServerCreationPageState();
}

class _ServerCreationPageState extends State<ServerCreationPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _serverNameController = TextEditingController();
  final _serverDescriptionController = TextEditingController();
  bool _isPublic = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
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
    _serverNameController.dispose();
    _serverDescriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _createServer() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock server creation success
      final newServer = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _serverNameController.text,
        'description': _serverDescriptionController.text,
        'isPublic': _isPublic,
        'icon': 'S',
        'color': Colors.purple.value,
      };
      
      setState(() {
        _isLoading = false;
      });
      
      widget.onServerCreated(newServer);
    }
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create a Server',
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
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _serverNameController,
                    decoration: const InputDecoration(
                      labelText: 'Server Name',
                      hintText: 'Enter a name for your server',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a server name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _serverDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Server Description',
                      hintText: 'Describe your server (optional)',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Server Privacy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: FussionColors.tertiaryBackground.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isPublic = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _isPublic 
                                    ? FussionColors.primary.withOpacity(0.2) 
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Public',
                                  style: TextStyle(
                                    color: _isPublic 
                                        ? FussionColors.primary 
                                        : Colors.white70,
                                    fontWeight: _isPublic 
                                        ? FontWeight.bold 
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isPublic = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !_isPublic 
                                    ? FussionColors.primary.withOpacity(0.2) 
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Private',
                                  style: TextStyle(
                                    color: !_isPublic 
                                        ? FussionColors.primary 
                                        : Colors.white70,
                                    fontWeight: !_isPublic 
                                        ? FontWeight.bold 
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _createServer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FussionColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Create Server',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}