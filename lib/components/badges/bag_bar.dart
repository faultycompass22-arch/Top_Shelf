import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';
import 'package:treefire/state/cart_store.dart';

class BagBar extends StatelessWidget {
  final VoidCallback onTap;
  const BagBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartStore.instance,
      builder: (context, _) {
        final qty = CartStore.instance.totalQty;
        if (qty <= 0) return const SizedBox.shrink();

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadii.card),
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.panel2,
                borderRadius: BorderRadius.circular(AppRadii.card),
                border: Border.all(color: AppColors.line),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x88000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: AppColors.gold, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    '$qty item${qty == 1 ? '' : 's'} in cart',
                    style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    CartStore.instance.subtotalLabel,
                    style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, color: AppColors.muted),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 