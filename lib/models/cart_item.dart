// lib/models/cart_item.dart

class CartItem {
  final String id;           // Firestore document ID
  final String title;        // Product title
  final String weightKey;    // gram | eighth | quarter | half | oz
  final int priceCents;      // price for selected weight
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.weightKey,
    required this.priceCents,
    required this.quantity,
  });

  CartItem copyWith({
    String? id,
    String? title,
    String? weightKey,
    int? priceCents,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      weightKey: weightKey ?? this.weightKey,
      priceCents: priceCents ?? this.priceCents,
      quantity: quantity ?? this.quantity,
    );
  }
}