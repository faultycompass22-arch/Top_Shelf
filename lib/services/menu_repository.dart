// lib/services/menu_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class MenuRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, int>> fetchWeightTiersCents() async {
    final snap = await _firestore.collection('app_config').doc('main').get();
    final data = snap.data() ?? {};
    final tiers = (data['weightTiers'] as Map<String, dynamic>?) ?? {};
    return {
      'gram': (tiers['gram'] ?? 0) as int,
      'eighth': (tiers['eighth'] ?? 0) as int,
      'quarter': (tiers['quarter'] ?? 0) as int,
      'half': (tiers['half'] ?? 0) as int,
      'oz': (tiers['oz'] ?? 0) as int,
    };
  }

  Future<List<Product>> fetchMenu() async {
    final tiers = await fetchWeightTiersCents();

    final menuSnap = await _firestore
        .collection('menu_items')
        .where('active', isEqualTo: true)
        .get();

    final products = menuSnap.docs.map((doc) {
      final d = doc.data();
      return Product(
        id: doc.id,
        title: (d['title'] ?? '') as String,
        type: (d['strain'] ?? '') as String,
        scent: (d['smell'] ?? '') as String,
        thca: 0,
        effects: const [],
        gramPrice: tiers['gram'] ?? 0,
        eighthPrice: tiers['eighth'] ?? 0,
        quarterPrice: tiers['quarter'] ?? 0,
        halfPrice: tiers['half'] ?? 0,
        ozPrice: tiers['oz'] ?? 0,
        imageKey: doc.id,
      );
    }).toList();

    products.sort((a, b) {
      final aSort = (menuSnap.docs.firstWhere((x) => x.id == a.id).data()['sort'] ?? 0) as int;
      final bSort = (menuSnap.docs.firstWhere((x) => x.id == b.id).data()['sort'] ?? 0) as int;
      return aSort.compareTo(bSort);
    });

    return products;
  }
}