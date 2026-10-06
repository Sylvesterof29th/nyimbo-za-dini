import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _favoritesKey = 'favorite_hymns';

  Future<SharedPreferences> get _preferences async {
    return SharedPreferences.getInstance();
  }

  Future<List<String>> getFavoriteHymns() async {
    final prefs = await _preferences;

    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> addFavorite(String hymnId) async {
    final prefs = await _preferences;

    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    if (!favorites.contains(hymnId)) {
      favorites.add(hymnId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFavorite(String hymnId) async {
    final prefs = await _preferences;

    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    favorites.remove(hymnId);

    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<bool> isFavorite(String hymnId) async {
    final favorites = await getFavoriteHymns();

    return favorites.contains(hymnId);
  }

  static const String _fontSizeKey = 'hymn_font_size';

  Future<double> getFontSize() async {
    final prefs = await _preferences;
    return prefs.getDouble(_fontSizeKey) ?? 18.0;
  }

  Future<void> saveFontSize(double fontSize) async {
    final prefs = await _preferences;
    await prefs.setDouble(_fontSizeKey, fontSize);
  }
}
