import 'package:flutter/material.dart';

import '../../services/menu_repository.dart';
import '../../state/cart_store.dart';
import '../../theme/tokens.dart';
import '../../menu/menu_item.dart';
import '../../menu/image_key_map.dart';
import '../../product/product_bottom_sheet.dart';
import '../../components/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repo = MenuRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroHeader(),
              const SizedBox(height: 14),
              Expanded(
                child: StreamBuilder<List<MenuItem>>(
                  stream: repo.watchFlowerMenu(),
                  builder: (context, snap) {
                    final items = snap.data ?? const <MenuItem>[];
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (items.isEmpty) {
                      return Center(
                        child: Text('No items found.', style: AppText.body.copyWith(color: AppColors.muted)),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.88,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return _ProductTile(
                          item: item,
                          onTap: () async {
                            final tiers = await repo.fetchWeightTiersCents();
                            if (!context.mounted) return;
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => ProductBottomSheet(
                                cartStore: widget.cartStore,
                                item: item,
                                weightTiersCents: tiers,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 130,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tf_hero.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(.70), Colors.black.withOpacity(.15)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppConstants.brand, style: AppText.h2),
              const SizedBox(height: 6),
              Text(AppConstants.subtitle, style: AppText.body.copyWith(color: AppColors.muted)),
              const Spacer(),
              Text('Premium Indoor', style: AppText.caption.copyWith(color: AppColors.gold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.item, required this.onTap});
  final MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final asset = ImageKeyMap.assetFor(item.id);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.stroke),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(asset, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(item.title, style: AppText.h3, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(item.strain, style: AppText.caption.copyWith(color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}