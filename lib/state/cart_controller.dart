import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';

class CartController extends ChangeNotifier {
  final Map<String, CartLine> _items = {};

  List<CartLine> get lines => _items.values.toList();

  int get itemCount =>
      _items.values.fold(0, (sum, line) => sum + line.quantity);

  int get totalCents =>
      _items.values.fold(0, (sum, line) => sum + line.totalCents);

  String _key(String itemId, String tier) => '$itemId|$tier';

  // =========================
  // NEW (tier-aware) API
  // =========================
  void addItemTiered({
    required MenuItem item,
    required String tier, // '1g', '1/8', '1/4'
    required int unitPriceCents, // canonical price in cents
  }) {
    final k = _key(item.id, tier);

    if (_items.containsKey(k)) {
      _items[k]!.quantity++;
    } else {
      _items[k] = CartLine(
        key: k,
        item: item,
        tier: tier,
        unitPriceCents: unitPriceCents,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  void removeOneTiered({
    required String itemId,
    required String tier,
  }) {
    final k = _key(itemId, tier);
    if (!_items.containsKey(k)) return;

    final line = _items[k]!;
    if (line.quantity > 1) {
      line.quantity--;
    } else {
      _items.remove(k);
    }
    notifyListeners();
  }

  // =========================
  // OLD API (to keep your app compiling)
  // cart_screen.dart expects these
  // =========================

  /// Old call: cart.addItem(item)
  /// Uses item.priceCents as canonical unit price.
  /// Default tier is 'default'.
  void addItem(MenuItem item) {
    final k = _key(item.id, 'default');
    if (_items.containsKey(k)) {
      _items[k]!.quantity++;
    } else {
      _items[k] = CartLine(
        key: k,
        item: item,
        tier: 'default',
        unitPriceCents: item.priceCents,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  /// Old call: cart.removeItem(itemId)
  /// Removes one quantity from the first matching line for that item id.
  void removeItem(String itemId) {
    // Find the first line key that starts with "itemId|"
    final key = _items.keys.cast<String?>().firstWhere(
          (k) => k != null && k.startsWith('$itemId|'),
      orElse: () => null,
    );

    if (key == null) return;

    final line = _items[key]!;
    if (line.quantity > 1) {
      line.quantity--;
    } else {
      _items.remove(key);
    }
    notifyListeners();
  }

  void removeLine(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class CartLine {
  final String key;
  final MenuItem item;
  final String tier; // 'default' or '1g'/'1/8'/'1/4'
  final int unitPriceCents;
  int quantity;

  CartLine({
    required this.key,
    required this.item,
    required this.tier,
    required this.unitPriceCents,
    required this.quantity,
  });

  int get totalCents => unitPriceCents * quantity;
}