import '../menu/menu_item.dart';

class CartItem {
  CartItem({
    required this.item,
    required this.grams,
    required this.priceCents,
    this.note,
  });

  final MenuItem item;
  int grams;
  int priceCents;
  String? note;
}