import 'dart:convert';

import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Stats> stats = [];
  String? errorMessage;

  String apiKey;

  StatsProvider(this.apiKey);

  void updateApiKey(String apiKey) {
    this.apiKey = apiKey; // Variable mutable
    notifyListeners();
  }

  Future<void> fetchStats() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('${Constants.mainUrl}/user/stats');
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
            stats = [Stats.fromJSON(body['data'])];
          } catch (e) {
            print('Error al procesar el usuario: $e');
            stats = [];
          }
        } else {
          print('Formato de datos inesperado.');
          stats = [];
        }
      } else if (response.statusCode == 401) {
        errorMessage = 'API Key inválida.';
        stats = [];
      } else {
        errorMessage = 'Error del servidor: ${response.statusCode}.';
        stats = [];
      }
    } catch (e) {
      errorMessage = 'Error al conectarse al servidor: $e';
      stats = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
