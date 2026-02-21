// lib/data/menu_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../features/menu/menu_item.dart';

class MenuRepository {
  MenuRepository._();
  static final MenuRepository instance = MenuRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Main menu stream (LIVE updates)
  Stream<List<MenuItem>> streamMenu() {
    return _firestore
        .collection('menu_items')
        .where('active', isEqualTo: true)
        .orderBy('sort', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MenuItem.fromFirestore(doc.id, doc.data()))
          .toList();
    });
  }

  /// One-time fetch (optional use)
  Future<List<MenuItem>> fetchMenuOnce() async {
    final snapshot = await _firestore
        .collection('menu_items')
        .where('active', isEqualTo: true)
        .orderBy('sort', descending: false)
        .get();

    return snapshot.docs
        .map((doc) => MenuItem.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  /// Fetch single item by ID
  Future<MenuItem?> fetchById(String id) async {
    final doc =
    await _firestore.collection('menu_items').doc(id).get();

    if (!doc.exists) return null;

    return MenuItem.fromFirestore(doc.id, doc.data()!);
  }
}