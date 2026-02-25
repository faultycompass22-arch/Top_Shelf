import 'package:flutter/material.dart';
import '../../components/utils/constants.dart';
import '../../components/utils/launchers.dart';
import '../../state/cart_store.dart';
import '../../theme/tokens.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    widget.cartStore.addListener(_onCart);
  }

  @override
  void dispose() {
    widget.cartStore.removeListener(_onCart);
    super.dispose();
  }

  void _onCart() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final items = widget.cartStore.items;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cart', style: AppText.h1),
              const SizedBox(height: 14),

              if (items.isEmpty)
                Expanded(
                  child: Center(
                    child: Text('Cart is empty.', style: AppText.body.copyWith(color: AppColors.muted)),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final ci = items[i];
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColors.stroke),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ci.item.title, style: AppText.h3),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Weight: ${ci.grams}g',
                                    style: AppText.caption.copyWith(color: AppColors.muted),
                                  ),
                                  if ((ci.note ?? '').isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(ci.note!, style: AppText.caption.copyWith(color: AppColors.gold)),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(_money(ci.priceCents), style: AppText.h3.copyWith(color: AppColors.gold)),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () => widget.cartStore.removeAt(i),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Total', style: AppText.h3),
                    ),
                    Text(_money(widget.cartStore.totalCents), style: AppText.h3.copyWith(color: AppColors.gold)),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: OutlinedButton(
                        onPressed: items.isEmpty ? null : () async => launchTel(AppConstants.callPhone),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.text,
                          side: BorderSide(color: AppColors.stroke),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Call to Order'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: items.isEmpty
                            ? null
                            : () async {
                          final lines = items
                              .map((x) => '- ${x.item.title} (${x.grams}g) ${_money(x.priceCents)}')
                              .join('\n');
                          final msg = 'Order:\n$lines\nTotal: ${_money(widget.cartStore.totalCents)}';
                          await launchSms(AppConstants.smsPhone, message: msg);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Text to Order'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _money(int cents) => '\$${(cents / 100.0).toStringAsFixed(2)}';
}