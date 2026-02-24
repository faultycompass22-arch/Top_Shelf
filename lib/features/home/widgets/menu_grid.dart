// lib/features/home/widgets/menu_grid.dart
import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../state/cart_store.dart';
import 'product_card.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key, required this.items, required this.cartStore});
  final List<Product> items;
  final CartStore cartStore;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 28),
          child: Center(child: Text('No items found.')),
        ),
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, i) => ProductCard(item: items[i], cartStore: cartStore),
        childCount: items.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.73,
      ),
    );
  }
}