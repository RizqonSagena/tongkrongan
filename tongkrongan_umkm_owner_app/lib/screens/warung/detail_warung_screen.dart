import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class DetailWarungScreen extends StatelessWidget {
  final String warungId;
  
  const DetailWarungScreen({
    super.key,
    required this.warungId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Detail Warung'),
        backgroundColor: AppTheme.surface,
      ),
      body: Center(
        child: Text(
          'Detail Warung Screen\nWarung ID: $warungId\n(To be implemented)',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppTheme.onSurface,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}