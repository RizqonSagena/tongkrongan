import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CategoryResultsScreen extends StatelessWidget {
  final String category;
  
  const CategoryResultsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Text('Results for: $category'),
        backgroundColor: AppTheme.surface,
      ),
      body: Center(
        child: Text(
          'Category Results Screen\nCategory: $category\n(To be implemented)',
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