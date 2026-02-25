import 'package:flutter/material.dart';

import '../../../menu/image_key_map.dart';
import '../../../menu/menu_item.dart';
import '../../../product/product_bottom_sheet.dart';
import '../../../theme/tokens.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final imagePath = ImageKeyMap.assetFor(item.id);

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ProductBottomSheet(item: item),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.stroke),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.h3,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _pill(item.type.toUpperCase()),
                const SizedBox(width: 8),
                Text(
                  'THCA ${item.thca.toStringAsFixed(1)}%',
                  style: AppText.caption.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: AppText.caption),
    );
  }
}
