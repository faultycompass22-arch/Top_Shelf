import 'package:flutter/material.dart';

import '../../theme/tokens.dart';
import '../../state/cart_store.dart';
import '../../components/utils/launchers.dart';
import '../menu/image_key_map.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartStore.instance,
      builder: (context, _) {
        final lines = CartStore.instance.lines;

        return Theme(
          data: Theme.of(context).copyWith(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          ),
          child: Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),
            appBar: AppBar(
              backgroundColor: const Color(0xFFFAFAFA),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.background),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Checkout',
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            body: lines.isEmpty
                ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  color: Color(0xFF111214),
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
                : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: lines.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final line = lines[index];
                      final item = line.item;

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(AppRadius.lg),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.08),
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(AppRadius.md),
                              child: SizedBox(
                                width: 62,
                                height: 62,
                                child: Image.asset(
                                  ImageKeyMap.assetForDocId(item.id),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      color: AppColors.background,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${line.qty} × \$${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(
                                          17, 18, 20, 0.70),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${line.lineTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.background,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '\$${CartStore.instance.subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const _PlaceholderRow(
                        title: 'Delivery info',
                        subtitle: 'Available after ordering by text/call',
                      ),
                      const SizedBox(height: 8),
                      const _PlaceholderRow(
                        title: 'Payment',
                        subtitle: 'No payments in-app tonight',
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final body =
                                CartStore.instance.buildOrderText();
                                launchTextOrder(body: body);
                              },
                              child: const Text('Text to Order'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: launchCallOrder,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                ),
                                foregroundColor: AppColors.background,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(AppRadius.lg),
                                ),
                              ),
                              child: const Text(
                                'Call',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          CartStore.instance.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Clear cart',
                          style: TextStyle(
                            color: Color.fromRGBO(17, 18, 20, 0.70),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlaceholderRow extends StatelessWidget {
  const _PlaceholderRow({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.08),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color.fromRGBO(17, 18, 20, 0.70),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}