// lib/features/product/product_bottom_sheet.dart
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../models/cart_item.dart';
import '../../services/cart_service.dart';
import '../../state/cart_store.dart';
import '../../theme/tokens.dart';
import '../menu/image_key_map.dart';

class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({super.key, required this.item, required this.cartStore});
  final Product item;
  final CartStore cartStore;

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  String _weightKey = 'eighth';
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final asset = ImageKeyMap.assetFor(item.imageKey);

    int price = item.priceForWeight(_weightKey);

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: Container(
                      width: 92,
                      height: 92,
                      color: AppColors.surface,
                      child: Image.asset(asset, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${item.type} • ${item.scent}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'COA: Available upon request',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select weight',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _weightChip('gram', '1g'),
                  _weightChip('eighth', '⅛'),
                  _weightChip('quarter', '¼'),
                  _weightChip('half', '½'),
                  _weightChip('oz', '1oz'),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  _qtyBtn(
                    icon: Icons.remove,
                    onTap: () => setState(() => _qty = (_qty - 1).clamp(1, 99)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '$_qty',
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ),
                  _qtyBtn(
                    icon: Icons.add,
                    onTap: () => setState(() => _qty = (_qty + 1).clamp(1, 99)),
                  ),
                  const Spacer(),
                  Text(
                    '\$${(price / 100).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      onPressed: () async {
                        await CartService.sendTextOrder(widget.cartStore);
                      },
                      child: const Text(
                        'Text to Order',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      onPressed: () {
                        widget.cartStore.addItem(
                          CartItem(
                            id: item.id,
                            title: item.title,
                            weightKey: _weightKey,
                            priceCents: price,
                            quantity: _qty,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _weightChip(String key, String label) {
    final selected = _weightKey == key;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      onTap: () => setState(() => _weightKey = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.surface : AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: selected ? AppColors.gold : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: selected ? AppColors.gold : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}