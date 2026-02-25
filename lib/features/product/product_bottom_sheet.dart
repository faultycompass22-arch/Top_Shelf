import 'package:flutter/material.dart';

import '../menu/menu_item.dart';
import '../menu/image_key_map.dart';
import '../state/cart_store.dart';
import '../theme/tokens.dart';
import '../components/utils/constants.dart';
import '../components/utils/launchers.dart';

class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({
    super.key,
    required this.cartStore,
    required this.item,
    required this.weightTiersCents,
  });

  final CartStore cartStore;
  final MenuItem item;
  final Map<num, int> weightTiersCents;

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  int grams = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final asset = ImageKeyMap.assetFor(item.id);

    final pricing = _priceFor(grams, widget.weightTiersCents);
    final priceCents = pricing.$1;
    final note = pricing.$2;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 46, height: 5, decoration: BoxDecoration(color: AppColors.stroke, borderRadius: BorderRadius.circular(99))),
            const SizedBox(height: 14),

            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: Colors.white,
                    child: Image.asset(asset, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppText.h2, maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _Pill(text: item.strain),
                          const SizedBox(width: 8),
                          _Pill(text: 'COA: upon request'),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 14),
            _InfoLine(label: 'Smell', value: item.smell),
            const SizedBox(height: 8),
            _InfoLine(label: 'Description', value: item.description),

            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.stroke),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select amount', style: AppText.caption.copyWith(color: AppColors.muted)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _QtyButton(
                        icon: Icons.remove,
                        onTap: grams > 1 ? () => setState(() => grams--) : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _displayWeightText(grams),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppColors.text,
                                letterSpacing: .5,
                              ),
                            ),
                            if (note != null) ...[
                              const SizedBox(height: 4),
                              Text(note, style: AppText.caption.copyWith(color: AppColors.gold)),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      _QtyButton(
                        icon: Icons.add,
                        onTap: grams < 28 ? () => setState(() => grams++) : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () async {
                        final msg = 'Order: ${item.title} • ${_displayWeightText(grams)}';
                        await launchSms(AppConstants.smsPhone, message: msg);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.text,
                        side: BorderSide(color: AppColors.stroke),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Text to Order'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.cartStore.add(
                          item,
                          grams: grams,
                          priceCents: priceCents,
                          note: note,
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(_money(priceCents)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // returns (priceCents, note)
  (int, String?) _priceFor(int grams, Map<num, int> tiers) {
    // Exact match first
    final exact = tiers[grams.toDouble()] ?? tiers[grams];
    if (exact != null) return (exact, grams == 6 ? 'Buy 6 get 1 free' : null);

    // Your special case: 6g should price like "7 grams" tier (stored under 7)
    if (grams == 6) {
      final seven = tiers[7] ?? tiers[7.0];
      if (seven != null) return (seven, 'Buy 6 get 1 free');
    }

    // fallback: find nearest lower tier
    final keys = tiers.keys.toList()..sort((a, b) => a.toDouble().compareTo(b.toDouble()));
    num best = keys.first;
    for (final k in keys) {
      if (k.toDouble() <= grams.toDouble()) best = k;
    }
    return (tiers[best] ?? 0, null);
  }

  String _displayWeightText(int grams) {
    if (grams == 7) return '7g (eighth)';
    if (grams == 14) return '14g (half)';
    if (grams == 28) return '1oz';
    if (grams == 6) return '6g + 1g FREE';
    return '${grams}g';
  }

  String _money(int cents) {
    final v = (cents / 100.0);
    return '\$${v.toStringAsFixed(2)}';
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 90, child: Text('$label:', style: AppText.caption.copyWith(color: AppColors.muted))),
        Expanded(child: Text(value, style: AppText.body)),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Icon(icon, color: onTap == null ? AppColors.muted : AppColors.text),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Text(text, style: AppText.caption.copyWith(color: AppColors.muted)),
    );
  }
}