import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/menu_item.dart';
import '../state/menu_controller.dart' as app_menu;

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  static const double kHeroHeight = 260;
  static const double kFlowerBarHeight = 64;
  static const double kTileRadius = 20;

  static const Color kEyeGreen = Color(0xFF1E6B52);
  static const Color kWarmOffWhite = Color(0xFFF6F1E7);

  static const int _tileCount = 4;

  final app_menu.MenuController _menu = app_menu.MenuController();

  @override
  void initState() {
    super.initState();
    _menu.load();
  }

  @override
  void dispose() {
    _menu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildHero(),
          _buildFlowerHeaderBar(context),
          Expanded(
            child: Container(
              color: kWarmOffWhite,
              padding: const EdgeInsets.all(20),
              child: AnimatedBuilder(
                animation: _menu,
                builder: (context, child) => _buildTiles(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return SizedBox(
      height: kHeroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/aaa_full_logo.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.35),
                  Colors.black.withValues(alpha: 0.15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowerHeaderBar(BuildContext context) {
    return Container(
      height: kFlowerBarHeight,
      width: double.infinity,
      color: kEyeGreen,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Flower',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => context.push('/account'),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Hi, Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTiles(BuildContext context) {
    final List<MenuItem> data = _menu.items;

    final tiles = List<MenuItem?>.generate(
      _tileCount,
          (i) => i < data.length ? data[i] : null,
    );

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tileCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = tiles[index];

        return InkWell(
          borderRadius: BorderRadius.circular(kTileRadius),
          onTap: item == null
              ? null
              : () {
            context.push('/item', extra: item);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kTileRadius),
              border: Border.all(color: kEyeGreen, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kTileRadius - 6),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _TileImage(url: item?.imageUrl),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        color: Colors.white.withValues(alpha: 0.92),
                        child: Text(
                          item?.title ?? '—',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    if (_menu.loading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withValues(alpha: 0.30),
                          alignment: Alignment.center,
                          child: const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B0B0B),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const ListTile(
              title: Text(
                'AAA Cannabis Delivery',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                'Private access',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            const Divider(color: Colors.white12),
            ListTile(
              leading: const Icon(Icons.shopping_bag_rounded,
                  color: Colors.white),
              title: const Text(
                'Account',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                context.push('/account');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TileImage extends StatelessWidget {
  final String? url;
  const _TileImage({required this.url});

  @override
  Widget build(BuildContext context) {
    final u = (url ?? '').trim();

    if (u.isEmpty) {
      return Container(
        color: const Color(0xFFF0F0F0),
        alignment: Alignment.center,
        child: const Icon(
          Icons.shopping_bag_rounded,
          size: 44,
          color: Colors.black26,
        ),
      );
    }

    return Image.network(
      u,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFF0F0F0),
          alignment: Alignment.center,
          child: const Icon(
            Icons.broken_image_outlined,
            size: 44,
            color: Colors.black26,
          ),
        );
      },
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: const Color(0xFFF0F0F0),
          alignment: Alignment.center,
          child: const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}