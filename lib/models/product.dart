// lib/models/product.dart

class Product {
  final String id;
  final String title;
  final String type;      // indica | sativa | hybrid
  final String scent;
  final double thca;
  final List<String> effects;

  final int gramPrice;
  final int eighthPrice;
  final int quarterPrice;
  final int halfPrice;
  final int ozPrice;

  final String imageKey; // maps to local asset image

  Product({
    required this.id,
    required this.title,
    required this.type,
    required this.scent,
    required this.thca,
    required this.effects,
    required this.gramPrice,
    required this.eighthPrice,
    required this.quarterPrice,
    required this.halfPrice,
    required this.ozPrice,
    required this.imageKey,
  });

  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      scent: data['scent'] ?? '',
      thca: (data['thca'] ?? 0).toDouble(),
      effects: List<String>.from(data['effects'] ?? []),
      gramPrice: data['gramPrice'] ?? 0,
      eighthPrice: data['eighthPrice'] ?? 0,
      quarterPrice: data['quarterPrice'] ?? 0,
      halfPrice: data['halfPrice'] ?? 0,
      ozPrice: data['ozPrice'] ?? 0,
      imageKey: data['imageKey'] ?? '',
    );
  }

  int priceForWeight(String weightKey) {
    switch (weightKey) {
      case 'gram':
        return gramPrice;
      case 'eighth':
        return eighthPrice;
      case 'quarter':
        return quarterPrice;
      case 'half':
        return halfPrice;
      case 'oz':
        return ozPrice;
      default:
        return gramPrice;
    }
  }
}