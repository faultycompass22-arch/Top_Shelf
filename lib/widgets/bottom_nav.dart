import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';

class BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const BottomNav({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.gold2.withValues(alpha: 0.35)),
        boxShadow: const [
          BoxShadow(color: Color(0xAA000000), blurRadius: 20, offset: Offset(0, 12)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_filled, label: 'Home', isOn: index == 0, onTap: () => onChanged(0)),
          _NavItem(icon: Icons.description_outlined, label: 'COA', isOn: index == 1, onTap: () => onChanged(1)),
          _NavItem(icon: Icons.shopping_bag_outlined, label: 'Cart', isOn: index == 2, onTap: () => onChanged(2)),
          _NavItem(icon: Icons.person_outline, label: 'Account', isOn: index == 3, onTap: () => onChanged(3)),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isOn;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.isOn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isOn ? AppColors.gold : AppColors.muted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}