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
  static const double kTileRadius = 18;

  static const Color kEmerald = Color(0xFF0F5C4A);
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
                builder: (context, _) => _buildTiles(context),
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
      color: kEmerald,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
              const Text(
                'Flower',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.white),
                onPressed: () => context.push('/account'),
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
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = tiles[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kTileRadius),
            border: Border.all(color: kEmerald, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(kTileRadius),
            onTap: item == null
                ? null
                : () {
              context.push(
                '/item',
                extra: {
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priceCents': item.priceCents,
                  'imageUrl': item.imageUrl,
                  'category': item.category,
                  'coaUrl': item.coaUrl,
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kTileRadius),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _TileImage(url: item?.imageUrl),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item?.title.isNotEmpty == true
                            ? item!.title
                            : (item == null ? '—' : 'Item'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  if (_menu.loading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.35),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                ],
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
              leading: const Icon(Icons.person_outline, color: Colors.white),
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
          Icons.local_florist,
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