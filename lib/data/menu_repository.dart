import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item.dart';

class MenuRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collection = 'menu_items';

  Future<List<MenuItem>> fetchMenu() async {
    final snapshot =
    await _db.collection(_collection).orderBy('sort').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return MenuItem(
        id: doc.id,
        title: data['title'] ?? '',
        category: data['category'] ?? '',
        description: data['description'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        priceCents: data['priceCents'] ?? 0,
      );
    }).toList();
  }

  Stream<List<MenuItem>> watchMenu() {
    return _db.collection(_collection).orderBy('sort').snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return MenuItem(
            id: doc.id,
            title: data['title'] ?? '',
            category: data['category'] ?? '',
            description: data['description'] ?? '',
            imageUrl: data['imageUrl'] ?? '',
            priceCents: data['priceCents'] ?? 0,
          );
        }).toList();
      },
    );
  }

  Future<void> saveMenuItem(MenuItem item) async {
    await _db.collection(_collection).doc(item.id).set(
      {
        'title': item.title,
        'category': item.category,
        'description': item.description,
        'imageUrl': item.imageUrl,
        'priceCents': item.priceCents,
        'sort': 0,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}