import 'package:flutter/material.dart';
import 'package:treefire/components/badges/bag_bar.dart';
import 'package:treefire/components/header/thca_flower_header_bar.dart';
import 'package:treefire/components/product_card/menu_item_card.dart';
import 'package:treefire/components/utils/constants.dart';
import 'package:treefire/components/utils/loading_indicator.dart';
import 'package:treefire/data/menu_repository.dart';
import 'package:treefire/features/menu/category_chip_row.dart';
import 'package:treefire/features/menu/menu_item.dart';
import 'package:treefire/features/product/product_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Flower';

  final categories = const ['Flower', 'Vapes', 'Edibles', 'Concentrates', 'Deals'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _TopBar(),
            const SizedBox(height: 10),

            // Search bar mock
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.panel2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.gold2.withValues(alpha: 0.35)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: AppColors.muted),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Search products & strains',
                        style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Icon(Icons.add, color: AppColors.gold),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            CategoryChipRow(
              categories: categories,
              selected: selectedCategory,
              onSelected: (v) => setState(() => selectedCategory = v),
            ),

            ThcaFlowerHeaderBar(
              leftTop: 'Top Shelf Certified',
              leftBottom: 'Premium Indoor',
              asset: 'assets/images/flower_bar.png',
            ),

            Expanded(
              child: StreamBuilder<List<MenuItem>>(
                stream: MenuRepository.instance.streamMenu(category: selectedCategory),
                builder: (context, snap) {
                  if (!snap.hasData) return const LoadingIndicator();
                  final items = snap.data!;

                  return Stack(
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 86),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, i) {
                          final item = items[i];
                          return MenuItemCard(
                            item: item,
                            onTap: () => ProductBottomSheet.open(context, item),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BagBar(
                          onTap: () {
                            // You can route to cart tab; left as noop here.
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.line),
              color: AppColors.panel2,
            ),
            child: const Icon(Icons.menu, color: AppColors.muted, size: 20),
          ),
          const Spacer(),
          const Text(
            'TREEfire',
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: 0.2,
            ),
          ),
          const Spacer(),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.line),
              color: AppColors.panel2,
            ),
            child: const Icon(Icons.person_outline, color: AppColors.muted, size: 20),
          ),
        ],
      ),
    );
  }
}