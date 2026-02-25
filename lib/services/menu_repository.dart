import 'package:cloud_firestore/cloud_firestore.dart';
import '../menu/menu_item.dart';

class MenuRepository {
  MenuRepository({FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;
  final FirebaseFirestore _db;

  Stream<List<MenuItem>> watchFlowerMenu() {
    return _db.collection('menu_items').snapshots().map((snap) {
      final items = snap.docs
          .map((d) => MenuItem.fromFirestore(d.id, d.data()))
          .where((x) => x.active && x.category.toLowerCase() == 'flower')
          .toList();

      items.sort((a, b) => a.sort.compareTo(b.sort));
      return items;
    });
  }

  Future<Map<num, int>> fetchWeightTiersCents() async {
    final doc = await _db.collection('app_conf').doc('main').get();
    final data = doc.data() ?? {};
    final tiers = (data['weightTiers'] as Map?)?.cast<String, dynamic>() ?? {};

    // keys look like: "1 gram", "3.5 grams", "7 grams", "oz"
    final out = <num, int>{};
    tiers.forEach((k, v) {
      final key = k.toLowerCase().trim();
      if (key == 'oz') {
        out[28] = (v as num).toInt();
        return;
      }
      final number = double.tryParse(key.split(' ').first);
      if (number != null) out[number] = (v as num).toInt();
    });
    return out;
  }
}