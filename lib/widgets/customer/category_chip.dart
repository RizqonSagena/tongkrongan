import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_home_screen.dart';

class CategoryChip extends StatelessWidget {
  final CategoryItem category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    required this.category, super.key,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? category.color : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emoji/Icon Container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected 
                    ? category.color.withValues(alpha: 0.1)
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  category.emoji,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Category Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected 
                      ? FontWeight.bold 
                      : FontWeight.w600,
                  color: isSelected 
                      ? category.color 
                      : Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}