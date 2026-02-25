class ImageKeyMap {
  static const _known = {
    'blue_nerds',
    'fruit_bops',
    'gelato_41',
    'maui_wowie',
  };

  static String assetFor(String id) {
    if (_known.contains(id)) return 'assets/images/$id.png';
    return 'assets/images/app_icon.png';
  }
}