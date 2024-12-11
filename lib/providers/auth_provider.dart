import 'package:app_aerofarallones/Auth/api_mananger.dart';
import 'package:app_aerofarallones/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _apiKey;

  String? get apiKey => _apiKey;

  bool get isAuthenticated => _apiKey != null && _apiKey!.isNotEmpty;

  Future<void> loadApiKey() async {
    _apiKey = await ApiKeyManager.getApiKey();
    print(_apiKey);
    if (_apiKey != null) {
      final isValid = await validateApiKey();
      if (!isValid) {
        await logout();
      }
    }
    notifyListeners();
  }

  Future<void> login(String apiKey) async {
    _apiKey = apiKey.trim();
    final cleanKey =
        _apiKey!.replaceAll(RegExp(r'[\u0000-\u001F\u007F-\u009F]'), '');
    final isValid = await validateApiKey();
    if (isValid) {
      await ApiKeyManager.saveApiKey(cleanKey);
      notifyListeners();
    } else {
      _apiKey = null;
      throw Exception("API Key inválida");
    }
  }

  Future<void> logout() async {
    _apiKey = null;
    await ApiKeyManager.deleteApiKey();
    notifyListeners();
  }

  Future<bool> validateApiKey() async {
    if (_apiKey == null) return false;

    final url = Uri.parse('${Constants.mainUrl}/user');
    final headers = {
      'X-API-Key': _apiKey!,
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        print('API Key inválida');
        return false;
      } else {
        print('Error del servidor: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error al validar la API Key: $e");
      return false;
    }
  }
}
