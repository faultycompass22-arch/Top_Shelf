import 'package:flutter/material.dart';
import 'package:treefire/components/utils/constants.dart';
import 'package:treefire/features/menu/menu_item.dart';
import 'package:treefire/features/menu/image_key_map.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onTap;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final img = ImageKeyMap.assetForDocId(item.id);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: AppColors.gold2.withValues(alpha: 0.45)),
            color: AppColors.panel,
            boxShadow: const [
              BoxShadow(
                color: Color(0x88000000),
                blurRadius: 14,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadii.card),
                    topRight: Radius.circular(AppRadii.card),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: AppColors.panel2),
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.85),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppRadii.pill),
                                border: Border.all(color: AppColors.gold.withValues(alpha: 0.55)),
                                color: Colors.black.withValues(alpha: 0.35),
                              ),
                              child: Text(
                                item.priceLabel,
                                style: const TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.muted, size: 18),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}