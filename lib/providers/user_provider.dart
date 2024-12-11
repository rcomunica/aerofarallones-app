import 'dart:convert';
import 'package:app_aerofarallones/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_aerofarallones/constants.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  List<User> user = [];
  String? errorMessage;

  String apiKey;

  // Constructor con API Key dinámica
  UserProvider(this.apiKey);

  void updateApiKey(String apiKey) {
    this.apiKey = apiKey; // Variable mutable
    notifyListeners();
  }

  Future<void> fetchUser() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('${Constants.mainUrl}/user');
    final headers = {
      'X-API-Key': apiKey,
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['data'] is Map) {
          try {
            user = [User.fromJSON(body['data'])];
          } catch (e) {
            print('Error al procesar el usuario: $e');
            user = [];
          }
        } else {
          print('Formato de datos inesperado.');
          user = [];
        }
      } else if (response.statusCode == 401) {
        print('API Key inválida.');
        user = [];
      } else {
        print('Error del servidor: ${response.statusCode}.');
        user = [];
      }
    } catch (e) {
      print('Error al conectarse al servidor: $e');
      user = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
