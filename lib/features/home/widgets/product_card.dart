// lib/features/home/widgets/product_card.dart
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../state/cart_store.dart';
import '../../../theme/tokens.dart';
import '../../menu/image_key_map.dart';
import '../../product/product_bottom_sheet.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item, required this.cartStore});
  final Product item;
  final CartStore cartStore;

  @override
  Widget build(BuildContext context) {
    final asset = ImageKeyMap.assetFor(item.imageKey);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ProductBottomSheet(item: item, cartStore: cartStore),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Container(
                  color: AppColors.surface,
                  child: Center(
                    child: Image.asset(
                      asset,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.type,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap for weights',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}