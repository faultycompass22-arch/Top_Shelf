// lib/features/menu/menu_item.dart
class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.priceCents,
    required this.category,
    required this.active,
    this.type,
    this.thca,
    this.effects = const [],
    this.scent,
    this.description,
    this.coaUrl,
    this.sort,
  });

  /// Firestore doc id (also used for local image: assets/images/{id}_1024.png)
  final String id;

  final String name;

  /// Firestore uses cents (e.g. 3250)
  final int priceCents;

  /// Display helper
  double get price => priceCents / 100.0;

  final String category; // "Flower", etc
  final bool active;

  final String? type; // Indica/Hybrid/Sativa (nullable if not present)
  final double? thca; // nullable if not present

  final List<String> effects;
  final String? scent;
  final String? description;
  final String? coaUrl;

  final int? sort;

  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    int _toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    }

    double? _toDoubleOrNull(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    bool _toBool(dynamic v) {
      if (v == null) return false;
      if (v is bool) return v;
      if (v is String) return v.toLowerCase() == 'true';
      if (v is num) return v != 0;
      return false;
    }

    List<String> _toStringList(dynamic v) {
      if (v == null) return const [];
      if (v is List) {
        return v.where((e) => e != null).map((e) => e.toString()).toList();
      }
      // Allow comma-separated fallback
      if (v is String) {
        return v
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return const [];
    }

    String _toStringSafe(dynamic v) => (v ?? '').toString();

    final coa = data['coaUrl']?.toString();
    final coaUrl = (coa == null || coa.trim().isEmpty) ? null : coa.trim();

    return MenuItem(
      id: id,
      name: _toStringSafe(data['name']),
      priceCents: _toInt(data['priceCents']),
      category: _toStringSafe(data['category']),
      active: _toBool(data['active']),
      type: data['type']?.toString(),
      thca: _toDoubleOrNull(data['thca']),
      effects: _toStringList(data['effects']),
      scent: data['scent']?.toString(),
      description: data['description']?.toString(),
      coaUrl: coaUrl,
      sort: (data['sort'] is num) ? (data['sort'] as num).toInt() : null,
    );
  }
}