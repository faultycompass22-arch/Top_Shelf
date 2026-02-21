// lib/app_shell.dart
import 'package:flutter/material.dart';

import 'theme/tokens.dart';

// Pages
import 'features/home/home_page.dart';
import 'features/cart/cart_page.dart';
import 'features/checkout/checkout_page.dart';
import 'features/coa/coa_page.dart';
import 'features/account/account_page.dart';

// Cart state (badge + edits)
import 'state/cart_store.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      const CoaPage(),
      const CartPage(),
      const AccountPage(),
    ];

    return AnimatedBuilder(
      animation: CartStore.instance,
      builder: (context, _) {
        final badgeCount = CartStore.instance.totalQty;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: IndexedStack(
            index: _index,
            children: pages,
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(color: AppColors.cardBorder),
                ),
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    label: 'Home',
                    icon: Icons.home_rounded,
                    selected: _index == 0,
                    onTap: () => setState(() => _index = 0),
                  ),
                  _NavItem(
                    label: 'COA',
                    icon: Icons.verified_rounded,
                    selected: _index == 1,
                    onTap: () => setState(() => _index = 1),
                  ),
                  _NavItem(
                    label: 'Cart',
                    icon: Icons.shopping_bag_rounded,
                    selected: _index == 2,
                    badgeCount: badgeCount,
                    onTap: () => setState(() => _index = 2),
                    // quick access to checkout (optional) — long press
                    onLongPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CheckoutPage()),
                      );
                    },
                  ),
                  _NavItem(
                    label: 'Account',
                    icon: Icons.person_rounded,
                    selected: _index == 3,
                    onTap: () => setState(() => _index = 3),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.onLongPress,
    this.badgeCount,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.gold : AppColors.textMuted;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 78,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 22, color: color),
                if ((badgeCount ?? 0) > 0)
                  Positioned(
                    right: -12,
                    top: -10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cartRed,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.background,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '${badgeCount ?? 0}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}