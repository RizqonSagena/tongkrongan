import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AutoPlayMonitoringScreen extends StatelessWidget {
  const AutoPlayMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Auto Play Monitoring'),
        backgroundColor: AppTheme.surface,
      ),
      body: const Center(
        child: Text(
          'Auto Play Monitoring Screen\n(To be implemented)',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.onSurface, fontSize: 18),
        ),
      ),
    );
  }
}