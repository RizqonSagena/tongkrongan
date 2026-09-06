import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_home_screen.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  const CategoryCard({
    required this.category, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/category-results/${category.name}');
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.onSurface.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppTheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}