import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyManager {
  static const _apiKeyKey = 'xApiKey';

  // Guardar API Key
  static Future<void> saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyKey, apiKey);
  }

  // Obtener API Key
  static Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyKey);
  }

  // Eliminar API Key
  static Future<void> deleteApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_apiKeyKey);
  }
}
