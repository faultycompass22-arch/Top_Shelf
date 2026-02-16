import 'package:cloud_firestore/cloud_firestore.dart';

class InviteService {
  InviteService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  /// Returns true if code is valid + enabled + has remaining uses.
  Future<bool> verifyAndConsumeCode(String rawCode) async {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty) return false;

    final snap = await _db
        .collection('invites')
        .where('code', isEqualTo: code)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return false;

    final doc = snap.docs.first;
    final data = doc.data();

    final enabled = (data['enabled'] as bool?) ?? false;
    final uses = (data['uses'] as num?)?.toInt() ?? 0;
    final maxUses = (data['maxUses'] as num?)?.toInt() ?? 0;

    if (!enabled) return false;
    if (maxUses > 0 && uses >= maxUses) return false;

    // Consume one use (atomic)
    await doc.reference.update({
      'uses': FieldValue.increment(1),
      'lastUsedAt': FieldValue.serverTimestamp(),
    });

    return true;
  }
}