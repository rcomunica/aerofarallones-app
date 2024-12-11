import 'dart:convert';
import 'package:app_aerofarallones/models/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_aerofarallones/constants.dart';

class NewsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<News> news = [];
  String? errorMessage;

  Future<void> fetchNews() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('${Constants.mainUrl}/news');
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['data'] is List) {
          try {
            news = List<News>.from(
              body['data'].map((news) => News.fromJSON(news)),
            );
          } catch (e) {
            news = [];
          }
        } else {
          print('Formato de datos inesperado.');
          news = [];
        }
      } else if (response.statusCode == 401) {
        print('API Key inválida.');
        news = [];
      } else {
        print('Error del servidor: ${response.statusCode}.');
        news = [];
      }
    } catch (e) {
      print('Error al conectarse al servidor: $e');
      news = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
