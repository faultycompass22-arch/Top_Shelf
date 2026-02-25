import 'package:flutter/material.dart';
import '../../../models/product.dart';
import 'product_card.dart';

class MenuGrid extends StatelessWidget {
  final List<Product> items;
  const MenuGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProductCard(product: items[index]);
      },
    );
  }
}