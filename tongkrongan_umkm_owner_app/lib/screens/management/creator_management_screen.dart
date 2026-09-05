import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CreatorManagementScreen extends StatelessWidget {
  const CreatorManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Creator Management'),
        backgroundColor: AppTheme.surface,
      ),
      body: const Center(
        child: Text(
          'Creator Management Screen\n(To be implemented)',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.onSurface, fontSize: 18),
        ),
      ),
    );
  }
}