import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Clave única para identificar los datos de esta app en la memoria del dispositivo.
  static const String _favoritesKey = 'favorites';
  
  // Funciones asíncronas para guardar (escritura) y cargar (lectura) la lista
  // de favoritos. Si no hay datos guardados, devuelve una lista por defecto.
  Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    // Retorna la lista guardada o una lista predeterminada si es la primera vez
    return prefs.getStringList(_favoritesKey) ?? ['si', 'no', 'duele', 'ayuda'];
  }
}