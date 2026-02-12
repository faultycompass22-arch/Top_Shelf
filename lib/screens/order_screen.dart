import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/menu_item_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  // =========================
  // TWEAK: Layout knobs (edit these)
  // =========================
  static const double kHeroExpandedHeight = 260; // TWEAK: hero image height
  static const double kExploreHeaderTopPad = 8; // TWEAK: move Explore Menu closer to hero (smaller = closer)
  static const double kExploreHeaderBottomPad = 14;
  static const double kExploreFontSize = 34; // TWEAK: Explore Menu font size
  static const double kGridSidePadding = 18; // TWEAK: left/right padding
  static const double kGridSpacing = 16; // TWEAK: tile spacing
  static const double kTileRadius = 22; // TWEAK: tile roundness

  // Demo data (swap later with your real menu list)
  static const int _demoCount = 12;

  @override
  Widget build(BuildContext context) {
    // =========================
    // PAGE STRUCTURE
    // - SliverAppBar = hero + hamburger + account button
    // - Pinned header = "Explore Menu"
    // - Body = grid that scrolls UNDER the pinned header
    // =========================
    return Scaffold(
      drawer: _buildDrawer(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          _buildHeroSliverAppBar(context),
          _buildExplorePinnedHeader(),
        ],
        body: _buildGrid(context),
      ),
    );
  }

  // =========================
  // HERO / TOP BAR
  // =========================
  SliverAppBar _buildHeroSliverAppBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      expandedHeight: kHeroExpandedHeight, // TWEAK: hero height (above)
      floating: false,
      pinned: false,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          // HERO IMAGE
          Image.asset(
            'assets/aaa_full_logo.png',
            fit: BoxFit.cover,
          ),

          // subtle dark overlay so icons look good
          Container(color: Colors.black.withOpacity(0.18)),

          // TOP ROW ICONS (hamburger + account)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // HAMBURGER
                  IconButton(
                    // TWEAK: icon size
                    iconSize: 26,
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),

                  // ACCOUNT (goes to /account)
                  IconButton(
                    iconSize: 24,
                    icon: const Icon(Icons.person_outline, color: Colors.white),
                    onPressed: () => context.push('/account'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // PINNED "EXPLORE MENU" HEADER
  // =========================
  SliverPersistentHeader _buildExplorePinnedHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PinnedHeaderDelegate(
        minHeight: 72,
        maxHeight: 72,
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(
            top: kExploreHeaderTopPad, // TWEAK: closer/farther from hero
            bottom: kExploreHeaderBottomPad,
          ),
          alignment: Alignment.bottomCenter,
          child: Text(
            'Explore Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: kExploreFontSize, // TWEAK: font size
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // GRID
  // =========================
  Widget _buildGrid(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 6) +
            const EdgeInsets.symmetric(horizontal: kGridSidePadding) +
            const EdgeInsets.only(bottom: 140), // keeps tiles above bag bar + nav
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: kGridSpacing,
          crossAxisSpacing: kGridSpacing,
          childAspectRatio: 1,
        ),
        itemCount: _demoCount,
        itemBuilder: (context, index) {
          return MenuItemCard(
            radius: kTileRadius, // TWEAK: tile roundness
            imagePath: 'assets/menu/flower.png',
            onTap: () {
              // Item details route
              context.push('/item', extra: {'index': index});
            },
          );
        },
      ),
    );
  }

  // =========================
  // DRAWER (Hamburger)
  // =========================
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B0B0B),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 12),
            const ListTile(
              title: Text(
                'AAA Cannabis Delivery',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'Private access',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            const Divider(color: Colors.white12),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Colors.white),
              title: const Text('Account', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.push('/account');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.white),
              title: const Text('Support', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PinnedHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_PinnedHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}
