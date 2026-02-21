// lib/features/home/widgets/menu_grid.dart

import 'package:flutter/material.dart';

import '../../../theme/tokens.dart';
import '../../../data/menu_repository.dart';
import '../../menu/menu_item.dart';
import 'product_card.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({
    super.key,
    required this.selectedCategory,
  });

  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MenuItem>>(
      stream: MenuRepository.instance.streamMenu(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.gold,
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No active menu items',
              style: TextStyle(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        var items = snapshot.data!;

        // Category filter (uses Firestore field "category")
        if (selectedCategory != 'All') {
          items = items
              .where((i) =>
          i.category.toLowerCase() ==
              selectedCategory.toLowerCase())
              .toList();
        }

        if (items.isEmpty) {
          return Center(
            child: Text(
              'No items in $selectedCategory',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ProductCard(item: items[index]);
          },
        );
      },
    );
  }
}