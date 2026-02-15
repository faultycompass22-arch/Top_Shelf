import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShellScreen extends StatefulWidget {
  final Widget child;
  const AppShellScreen({super.key, required this.child});

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  // route -> index
  int _indexFromLocation(String location) {
    if (location.startsWith('/cart')) return 1;
    if (location.startsWith('/rewards')) return 2;
    if (location.startsWith('/account')) return 3;
    return 0; // /app
  }

  // index -> route
  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/app');
        break;
      case 1:
        context.go('/cart');
        break;
      case 2:
        context.go('/rewards');
        break;
      case 3:
        context.go('/account');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      body: widget.child,

      // Bottom nav stays mostly dark; selected tab pops with accent.
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: _PremiumBottomNav(
            currentIndex: currentIndex,
            onTap: _onTap,
          ),
        ),
      ),
    );
  }
}

class _PremiumBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _PremiumBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Accent options: gold or emerald. We’re using gold for selected tab for now.
    const gold = Color(0xFFD7B46A);

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 22,
                offset: const Offset(0, 12),
                color: Colors.black.withValues(alpha: 0.45),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavPill(
                label: 'Home',
                icon: Icons.home_rounded,
                selected: currentIndex == 0,
                accent: gold,
                onTap: () => onTap(0),
              ),
              _NavPill(
                label: 'Cart',
                icon: Icons.shopping_bag_rounded,
                selected: currentIndex == 1,
                accent: gold,
                onTap: () => onTap(1),
              ),
              _NavPill(
                label: 'Rewards',
                icon: Icons.local_fire_department_rounded,
                selected: currentIndex == 2,
                accent: gold,
                onTap: () => onTap(2),
              ),
              _NavPill(
                label: 'Account',
                icon: Icons.person_rounded,
                selected: currentIndex == 3,
                accent: gold,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  const _NavPill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.black : Colors.white.withValues(alpha: 0.90);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? accent : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: fg, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}