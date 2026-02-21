// lib/features/product/product_bottom_sheet.dart

import 'package:flutter/material.dart';

import '../../theme/tokens.dart';
import '../../state/cart_store.dart';
import '../menu/menu_item.dart';
import '../menu/image_key_map.dart';
import '../../utils/launchers.dart';

class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({super.key, required this.item});

  final MenuItem item;

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle + close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 36),
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.cardBorder,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Badges row
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if ((item.type ?? '').isNotEmpty)
                          _Pill(
                            text: item.type!,
                            bg: AppColors.surface2,
                            fg: AppColors.textPrimary,
                            border: AppColors.cardBorder,
                          ),
                        if (item.thca != null)
                          _Pill(
                            text: 'THCA ${item.thca!.toStringAsFixed(1)}%',
                            bg: AppColors.surface2,
                            fg: AppColors.gold,
                            border: AppColors.goldBorder,
                          ),
                        _Pill(
                          text: item.category,
                          bg: AppColors.surface2,
                          fg: AppColors.textMuted,
                          border: AppColors.cardBorder,
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: AspectRatio(
                        aspectRatio: 1.3,
                        child: Image.asset(
                          ImageKeyMap.assetForDocId(item.id),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Effects
                    if (item.effects.isNotEmpty) ...[
                      const Text(
                        'Effects',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: item.effects
                            .take(8)
                            .map(
                              (e) => _Pill(
                            text: e,
                            bg: AppColors.surface2,
                            fg: AppColors.textPrimary,
                            border: AppColors.cardBorder,
                          ),
                        )
                            .toList(),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Scent
                    if ((item.scent ?? '').trim().isNotEmpty) ...[
                      Row(
                        children: [
                          const Icon(Icons.local_florist,
                              size: 16, color: AppColors.textMuted),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.scent!,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Description
                    if ((item.description ?? '').trim().isNotEmpty) ...[
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description!,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Price
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.gold,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // COA button
                    _CoaBlock(item: item),

                    const SizedBox(height: 18),
                  ],
                ),
              ),

              // Bottom actions (qty + add to cart + text/call)
              _BottomActions(
                qty: _qty,
                onDec: () => setState(() => _qty = (_qty - 1).clamp(1, 99)),
                onInc: () => setState(() => _qty = (_qty + 1).clamp(1, 99)),
                onAdd: () {
                  CartStore.instance.add(item, qty: _qty);
                  Navigator.of(context).pop();
                },
                onText: () => launchTextOrder(productName: item.name),
                onCall: launchCallOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.qty,
    required this.onDec,
    required this.onInc,
    required this.onAdd,
    required this.onText,
    required this.onCall,
  });

  final int qty;
  final VoidCallback onDec;
  final VoidCallback onInc;
  final VoidCallback onAdd;
  final VoidCallback onText;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: const Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Row(
            children: [
              _QtyStepper(qty: qty, onDec: onDec, onInc: onInc),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onText,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.goldBorder),
                    foregroundColor: AppColors.textPrimary,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                  child: const Text(
                    'Text to Order',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: onCall,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.cardBorder),
                    foregroundColor: AppColors.textPrimary,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                  child: const Text(
                    'Call',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.qty,
    required this.onDec,
    required this.onInc,
  });

  final int qty;
  final VoidCallback onDec;
  final VoidCallback onInc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.cardBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconBtn(icon: Icons.remove, onTap: onDec),
          const SizedBox(width: 10),
          Text(
            '$qty',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          _IconBtn(icon: Icons.add, onTap: onInc),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.text,
    required this.bg,
    required this.fg,
    required this.border,
  });

  final String text;
  final Color bg;
  final Color fg;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _CoaBlock extends StatelessWidget {
  const _CoaBlock({required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final hasCoa = (item.coaUrl ?? '').trim().isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.cardBorder),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.article_rounded, color: AppColors.textMuted),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              hasCoa ? 'COA available' : 'COA available upon request',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (hasCoa) {
                // For tonight: open URL in browser (later can be overlay viewer)
                launchUrlExternal(item.coaUrl!);
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: const Text(
                      'COA Available Upon Request',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    content: const Text(
                      'COA available upon request. Text or call to receive lab report.',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: AppColors.gold),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text(
              hasCoa ? 'View' : 'Info',
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}