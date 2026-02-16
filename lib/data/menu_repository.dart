import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item.dart';

class MenuRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collection = 'menu_items';

  Future<List<MenuItem>> fetchMenu() async {
    final snapshot = await _db.collection(_collection).orderBy('sort').get();

    return snapshot.docs.map((doc) {
      return MenuItem.fromFirestore(doc.id, doc.data());
    }).toList();
  }

  Stream<List<MenuItem>> watchMenu() {
    return _db.collection(_collection).orderBy('sort').snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          return MenuItem.fromFirestore(doc.id, doc.data());
        }).toList();
      },
    );
  }

  Future<void> saveMenuItem(MenuItem item) async {
    await _db.collection(_collection).doc(item.id).set(
      {
        ...item.toFirestore(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}