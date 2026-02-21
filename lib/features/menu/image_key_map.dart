// lib/features/menu/image_key_map.dart

/// This file connects your Firestore document ID
/// to the correct local Flutter asset image.
///
/// Firestore:
///   menu_items
///     └── blue_nerds (doc id)
///
/// Flutter asset:
///   assets/images/blue_nerds_1024.png
///
/// We use the document ID directly and construct
/// the correct image path automatically.

class ImageKeyMap {
  static const String _basePath = 'assets/images';

  /// Returns the correct asset path for a Firestore doc ID
  ///
  /// Example:
  ///   doc.id = "blue_nerds"
  ///
  ///   returns:
  ///   assets/images/blue_nerds_1024.png
  static String assetForDocId(String docId) {
    return '$_basePath/${docId}_1024.png';
  }
}