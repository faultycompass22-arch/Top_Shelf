// lib/services/menu_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class MenuRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchMenu() async {
    final configSnap =
    await _firestore.collection('app_config').doc('main').get();

    final weightTiers =
    configSnap.data()?['weightTiers'] as Map<String, dynamic>;

    final menuSnap = await _firestore
        .collection('menu_items')
        .where('active', isEqualTo: true)
        .get();

    final products = menuSnap.docs.map((doc) {
      final data = doc.data();

      return Product(
        id: doc.id,
        title: data['title'] ?? '',
        type: data['strain'] ?? '',
        scent: data['smell'] ?? '',
        thca: 0, // not stored in Firestore currently
        effects: [],
        gramPrice: weightTiers['gram'] ?? 0,
        eighthPrice: weightTiers['eighth'] ?? 0,
        quarterPrice: weightTiers['quarter'] ?? 0,
        halfPrice: weightTiers['half'] ?? 0,
        ozPrice: weightTiers['oz'] ?? 0,
        imageKey: doc.id, // maps directly to local asset name
      );
    }).toList();

    products.sort((a, b) {
      final aSort = menuSnap.docs
          .firstWhere((d) => d.id == a.id)
          .data()['sort'] ?? 0;

      final bSort = menuSnap.docs
          .firstWhere((d) => d.id == b.id)
          .data()['sort'] ?? 0;

      return aSort.compareTo(bSort);
    });

    return products;
  }
}