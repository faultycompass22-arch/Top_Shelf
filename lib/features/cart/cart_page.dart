// lib/features/cart/cart_page.dart

import 'package:flutter/material.dart';

import '../../theme/tokens.dart';
import '../../state/cart_store.dart';
import '../checkout/checkout_page.dart';
import '../menu/image_key_map.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartStore.instance,
      builder: (context, _) {
        final lines = CartStore.instance.lines;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              'Cart',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: lines.isEmpty
              ? const Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(color: AppColors.textMuted),
            ),
          )
              : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: lines.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final line = lines[index];
                    final item = line.item;

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                        BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                            color: AppColors.cardBorder),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                AppRadius.md),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                ImageKeyMap.assetForDocId(
                                    item.id),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    color:
                                    AppColors.textPrimary,
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                    fontWeight:
                                    FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Qty stepper
                                Row(
                                  children: [
                                    _IconBtn(
                                      icon: Icons.remove,
                                      onTap: () =>
                                          CartStore.instance
                                              .dec(item),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${line.qty}',
                                      style: const TextStyle(
                                        color: AppColors
                                            .textPrimary,
                                        fontWeight:
                                        FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _IconBtn(
                                      icon: Icons.add,
                                      onTap: () =>
                                          CartStore.instance
                                              .inc(item),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () =>
                                          CartStore.instance
                                              .remove(item.id),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color:
                                        AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Subtotal + checkout
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  border: Border(
                    top: BorderSide(
                        color: AppColors.cardBorder),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(
                    16, 14, 16, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                        Text(
                          '\$${CartStore.instance.subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight:
                            FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                              const CheckoutPage(),
                            ),
                          );
                        },
                        child:
                        const Text('Proceed to Checkout'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}