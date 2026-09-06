import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class WarungCard extends StatelessWidget {
  final String id;
  final String name;
  final String category;
  final double rating;
  final int reviewCount;
  final String distance;
  final int priceStart;
  final String imageUrl;
  final bool isOpen;
  final VoidCallback? onTap;

  const WarungCard({
    required this.id, required this.name, required this.category, required this.rating, required this.reviewCount, required this.distance, required this.priceStart, required this.imageUrl, super.key,
    this.isOpen = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 288,
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            _buildImageSection(),
            
            // Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spaceSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Text(
                      category,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 2),
                    
                    // Name
                    Text(
                      name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Rating and reviews
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: AppTheme.tertiaryContainer,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          rating.toString(),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: AppTheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($reviewCount ulasan)',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Price and button section
                    _buildBottomSection(context, currencyFormat),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 144,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          // Main image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.surfaceContainerHigh,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme.surfaceContainerHigh,
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 48,
                    color: AppTheme.outline,
                  ),
                ),
              ),
            ),
          ),
          
          // Status badge (top left)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isOpen ? AppTheme.secondary : AppTheme.errorContainer,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.onSurface.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isOpen ? AppTheme.onSecondary : AppTheme.onErrorContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isOpen ? 'Buka' : 'Tutup',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isOpen ? AppTheme.onSecondary : AppTheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Distance badge (top right)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.onSurface.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.near_me,
                    size: 14,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    distance,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Order type badge (bottom left)
          Positioned(
            bottom: 8,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.onSurface.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.storefront,
                    size: 12,
                    color: AppTheme.primary,
                  ),
                  SizedBox(width: 3),
                  const Text(
                    'Pesan Langsung di Tempat',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: -AppTheme.spaceSm),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MULAI',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
              Text(
                currencyFormat.format(priceStart),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Kunjungi Warung',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.directions,
                  size: 14,
                  color: AppTheme.onPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}