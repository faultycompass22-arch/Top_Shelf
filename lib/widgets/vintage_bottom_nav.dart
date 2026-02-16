// lib/widgets/vintage_bottom_nav.dart
//
// Drop-in “crate tile” bottom nav that matches the visual mock.
// - 4 items: Home, Cart, COAs, Account
// - Mini wood-frame tiles with an “oil spot” vignette
// - Clean icon + label (NO branding on the bag)
//
// Usage:
//   Scaffold(
//     body: child,
//     bottomNavigationBar: VintageBottomNavBar(
//       currentIndex: index,
//       onTap: (i) => setState(() => index = i),
//     ),
//   );
//
// If you're using go_router, see the note at bottom for route wiring.

import 'package:flutter/material.dart';

class VintageBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const VintageBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Tweak these once to match your brand
    const bgHeight = 92.0;
    const padH = 14.0;
    const padV = 10.0;
    const emerald = Color(0xFF1F8A5B);
    const cream = Color(0xFFF3E8D0);
    const ink = Color(0xFF2C1E16);

    return SafeArea(
      top: false,
      child: Container(
        height: bgHeight,
        padding: const EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        decoration: const BoxDecoration(
          // Dark leather-ish base (use an asset if you want later)
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF12100E),
              Color(0xFF090807),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _VintageNavItem(
                label: "Home",
                icon: Icons.home_rounded,
                selected: currentIndex == 0,
                onTap: () => onTap(0),
                emerald: emerald,
                cream: cream,
                ink: ink,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _VintageNavItem(
                label: "Cart",
                icon: Icons.shopping_bag_rounded,
                selected: currentIndex == 1,
                onTap: () => onTap(1),
                emerald: emerald,
                cream: cream,
                ink: ink,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _VintageNavItem(
                label: "COAs",
                icon: Icons.description_rounded,
                selected: currentIndex == 2,
                onTap: () => onTap(2),
                emerald: emerald,
                cream: cream,
                ink: ink,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _VintageNavItem(
                label: "Account",
                icon: Icons.person_rounded,
                selected: currentIndex == 3,
                onTap: () => onTap(3),
                emerald: emerald,
                cream: cream,
                ink: ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VintageNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color emerald;
  final Color cream;
  final Color ink;

  const _VintageNavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.emerald,
    required this.cream,
    required this.ink,
  });

  @override
  Widget build(BuildContext context) {
    // Tile sizing
    const tileHeight = 70.0;
    const radius = 16.0;

    // Icon + label styling
    final iconColor = selected ? cream : cream.withOpacity(0.92);
    final labelColor = selected ? cream : cream.withOpacity(0.88);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        height: tileHeight,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          // Wood frame texture – swap to your real asset when ready:
          // image: DecorationImage(image: AssetImage("assets/ui/wood_frame_small.png"), fit: BoxFit.cover),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A4A33),
              Color(0xFF3D2A1F),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: selected ? 14 : 10,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.35),
            ),
            if (selected)
              BoxShadow(
                blurRadius: 18,
                offset: const Offset(0, 0),
                color: emerald.withOpacity(0.25),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius - 2),
          child: Stack(
            children: [
              // Inner “crate bed”
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2A1C14),
                        Color(0xFF1A120D),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(radius - 2),
                  ),
                ),
              ),

              // Oil spot / vignette (NO rays)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.9,
                      colors: [
                        Colors.black.withOpacity(selected ? 0.18 : 0.26),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.85],
                    ),
                  ),
                ),
              ),

              // Inner white-ish “window” for icon
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8D0), // cream panel
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        color: Colors.black.withOpacity(0.18),
                      )
                    ],
                    border: Border.all(
                      color: const Color(0xFF2C1E16).withOpacity(0.18),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 22, color: ink.withOpacity(0.95)),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Cinzel", // swap if you want
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: ink.withOpacity(0.95),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Selected indicator dot (subtle, matches mock vibe)
              if (selected)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: emerald,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: emerald.withOpacity(0.55),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              // Tap feedback overlay
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    splashColor: emerald.withOpacity(0.12),
                    highlightColor: Colors.white.withOpacity(0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}