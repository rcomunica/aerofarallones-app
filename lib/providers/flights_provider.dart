import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_aerofarallones/models/flight.dart';
import 'package:app_aerofarallones/constants.dart';

class FlightsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Flight> flights = [];
  String? errorMessage;

  String apiKey;

  // Constructor con API Key dinámica
  FlightsProvider(this.apiKey);

  void updateApiKey(String apiKey) {
    this.apiKey = apiKey; // Variable mutable
    notifyListeners();
  }

  Future<void> fetchFlights() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('${Constants.mainUrl}/pireps');
    final headers = {
      'X-API-Key': apiKey,
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['data'] is List) {
          flights = List<Flight>.from(
            body['data'].map((flight) => Flight.fromJSON(flight)),
          );
        } else {
          errorMessage = 'Formato de datos inesperado.';
          flights = [];
        }
      } else if (response.statusCode == 401) {
        errorMessage = 'API Key inválida.';
        flights = [];
      } else {
        errorMessage = 'Error del servidor: ${response.statusCode}.';
        flights = [];
      }
    } catch (e) {
      errorMessage = 'Error al conectarse al servidor: $e';
      flights = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
