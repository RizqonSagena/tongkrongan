import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Explore Map'),
        backgroundColor: AppTheme.surface,
      ),
      body: const Center(
        child: Text(
          'Map Screen\n(To be implemented)',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.onSurface,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}