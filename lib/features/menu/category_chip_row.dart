import 'package:flutter/material.dart';

import '../../theme/tokens.dart';

class CategoryChipRow extends StatelessWidget {
  const CategoryChipRow({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, i) {
          final cat = categories[i];
          final isSelected = cat == selected;

          return GestureDetector(
            onTap: () => onSelect(cat),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.gold.withOpacity(0.20) : AppColors.panel,
                border: Border.all(
                  color: isSelected ? AppColors.gold : AppColors.stroke,
                ),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Text(
                cat,
                style: AppText.caption.copyWith(
                  color: isSelected ? AppColors.gold : AppColors.muted,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: categories.length,
      ),
    );
  }
}
