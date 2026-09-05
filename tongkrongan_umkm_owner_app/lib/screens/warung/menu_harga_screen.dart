import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class MenuHargaScreen extends StatelessWidget {
  final String warungId;
  
  const MenuHargaScreen({
    super.key,
    required this.warungId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Menu & Harga'),
        backgroundColor: AppTheme.surface,
      ),
      body: Center(
        child: Text(
          'Menu & Harga Screen\nWarung ID: $warungId\n(To be implemented)',
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