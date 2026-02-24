// lib/features/menu/image_key_map.dart
class ImageKeyMap {
  static String assetFor(String imageKey) {
    // Firestore doc ids match asset file names in assets/images/
    // e.g. blue_nerds -> assets/images/blue_nerds.png
    return 'assets/images/$imageKey.png';
  }
}