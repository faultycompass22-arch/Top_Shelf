// lib/widgets/thca_flower_header_bar.dart
//
// Cherry-wood "THCA Flower" header bar
// - Left: hamburger (opens Scaffold drawer OR calls onMenuTap)
// - Center: "THCA" (serif) + "Flower" (cursive)
// - Right: account icon (calls onAccountTap)
// - Cream text/icons, subtle shadow, no glow
//
// Usage (under your hero):
//   ThcaFlowerHeaderBar(
//     titleLeft: "THCA",
//     titleRight: "Flower",
//     onMenuTap: () => Scaffold.of(context).openDrawer(),
//     onAccountTap: () => context.go('/account'),
//   );
//
// Fonts:
// - If you have Cinzel for the brand serif, keep it.
// - For cursive, pick a script font you like (e.g., "GreatVibes", "Allura").
//   If you don't have a script font yet, it will fall back gracefully.

import 'package:flutter/material.dart';

class ThcaFlowerHeaderBar extends StatelessWidget {
  final String titleLeft;   // "THCA"
  final String titleRight;  // "Flower"
  final VoidCallback? onMenuTap;
  final VoidCallback? onAccountTap;

  /// If you prefer the bar to be tappable as a whole later, we can add onTitleTap.
  const ThcaFlowerHeaderBar({
    super.key,
    this.titleLeft = "THCA",
    this.titleRight = "Flower",
    this.onMenuTap,
    this.onAccountTap,
  });

  @override
  Widget build(BuildContext context) {
    const cream = Color(0xFFF3E8D0);

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        // Cherry wood feel (gradient + subtle vignette)
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7B2E1E), // cherry highlight
            Color(0xFF4B1A12), // deeper cherry
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle center brightening (NO rays)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.15,
                  colors: [
                    Colors.white.withOpacity(0.10),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.85],
                ),
              ),
            ),
          ),

          // Content row
          Row(
            children: [
              _IconHit(
                icon: Icons.menu_rounded,
                color: cream,
                onTap: onMenuTap ??
                        () {
                      // Fallback: open drawer if present
                      final scaffold = Scaffold.maybeOf(context);
                      scaffold?.openDrawer();
                    },
              ),
              const Spacer(),
              _TitleLockup(
                left: titleLeft,
                right: titleRight,
                color: cream,
              ),
              const Spacer(),
              _IconHit(
                icon: Icons.person_rounded,
                color: cream,
                onTap: onAccountTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconHit extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _IconHit({
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 24, color: color),
        ),
      ),
    );
  }
}

class _TitleLockup extends StatelessWidget {
  final String left;
  final String right;
  final Color color;

  const _TitleLockup({
    required this.left,
    required this.right,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Brand serif + script (set these to your real fonts once added in pubspec)
    const serifFont = "Cinzel";
    const scriptFont = "GreatVibes"; // will fall back if not installed

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: left.toUpperCase(),
            style: TextStyle(
              fontFamily: serifFont,
              fontSize: 20, // slightly smaller
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
              color: color,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.35),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const TextSpan(text: " "),
          TextSpan(
            text: right,
            style: TextStyle(
              fontFamily: scriptFont,
              fontSize: 26, // slightly larger than THCA
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: color,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.35),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}