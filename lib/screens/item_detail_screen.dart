import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/menu_item.dart';
import '../state/cart_controller.dart';
import '../widgets/bag_bar.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    super.key,
    required this.item,
  });

  final MenuItem item;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  static const Color kEyeGreen = Color(0xFF1E6B52);
  static const Color kWarmOffWhite = Color(0xFFF6F1E7);
  static const Color kInfoBlue = Color(0xFF2A6FD6);

  String _tier = '1g';

  int get _tierPriceCents {
    switch (_tier) {
      case '1/8':
        return 3500; // $35.00 total
      case '1/4':
        return 6500; // $65.00 total
      default:
        return 1089; // $10.89 total
    }
  }

  String _money(int cents) => '\$${(cents / 100).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    final imageUrl = widget.item.imageUrl.trim();
    final desc = widget.item.description.trim();
    final coaUrl = (widget.item.coaUrl ?? '').trim();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // HERO (smaller)
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                imageUrl.isEmpty
                    ? Container(color: Colors.black)
                    : Image.network(imageUrl, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.45),
                        Colors.black.withValues(alpha: 0.20),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CONTENT + BAG BAR
          Expanded(
            child: Container(
              color: kWarmOffWhite,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: kEyeGreen, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // NAME
                            Text(
                              widget.item.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // TIERS
                            Row(
                              children: ['1g', '1/8', '1/4'].map((t) {
                                final selected = _tier == t;
                                return Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    child: GestureDetector(
                                      onTap: () => setState(() => _tier = t),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selected
                                              ? kEyeGreen
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          border: Border.all(
                                            color: kEyeGreen,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            t,
                                            style: TextStyle(
                                              color: selected
                                                  ? Colors.white
                                                  : kEyeGreen,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 22),

                            // PRICE (FINAL)
                            Text(
                              _money(_tierPriceCents),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Tax & processing included',
                              style: TextStyle(
                                color: kInfoBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 22),

                            // DESCRIPTION (admin-controlled)
                            Text(
                              desc.isEmpty ? 'No description available.' : desc,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 18),

                            // COA
                            if (coaUrl.isNotEmpty)
                              GestureDetector(
                                onTap: () => context.push('/coa', extra: coaUrl),
                                child: const Text(
                                  'See COA',
                                  style: TextStyle(
                                    color: kEyeGreen,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),

                            const SizedBox(height: 28),

                            // COMPLIANCE LINE
                            const Text(
                              'THC < 0.3% — Compliant with the 2018 Farm Bill',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 22),

                            // ADD TO CART
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kEyeGreen,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<CartController>().addItem(
                                    item: widget.item,
                                    tier: _tier,
                                    unitPriceCents: _tierPriceCents,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Added ${widget.item.title} ($_tier)'),
                                      duration: const Duration(milliseconds: 700),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // BAG BAR
                  BagBar(
                    count: cart.itemCount,
                    totalCents: cart.totalCents,
                    onTap: () => context.go('/cart'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}