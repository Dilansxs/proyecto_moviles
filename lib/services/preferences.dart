import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _favoritesKey = 'favorites';
  
  Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? ['si', 'no', 'duele', 'ayuda'];
  }
}