import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';

class CategoryChipRow extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryChipRow({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final c = categories[i];
          final isOn = c == selected;

          return InkWell(
            onTap: () => onSelected(c),
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                color: isOn ? AppColors.gold.withValues(alpha: 0.18) : AppColors.panel2,
                border: Border.all(
                  color: isOn ? AppColors.gold : AppColors.line,
                ),
              ),
              child: Text(
                c,
                style: TextStyle(
                  color: isOn ? AppColors.gold : AppColors.muted,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}