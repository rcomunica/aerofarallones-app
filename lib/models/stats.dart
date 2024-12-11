import 'package:flutter/material.dart';

class Stats {
  int flights;
  String totalTime;
  String averageTime;
  String averageScore;
  double balance;
  String averageFuel;
  String averageLanding;

  Stats({
    required this.flights,
    required this.totalTime,
    required this.averageTime,
    required this.averageScore,
    required this.balance,
    required this.averageFuel,
    required this.averageLanding,
  });

  factory Stats.fromJSON(Map<String, dynamic> json) {
    return Stats(
      flights: json["flights"],
      totalTime: json["total_time"],
      averageTime: json["average_time"],
      averageScore: json["average_score"],
      balance: json["balance"],
      averageFuel: json["average_fuel"],
      averageLanding: json["average_landing"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "flights": {
        "data": flights,
        "name": "Total flights",
        "icon": Icons.public
      },
      "totalTime": {
        "data": totalTime,
        "name": "Total time",
        "icon": Icons.hourglass_top
      },
      "averageTime": {
        "data": averageTime,
        "name": "Average time",
        "icon": Icons.schedule
      },
      "averageScore": {
        "data": averageScore,
        "name": "Average Score",
        "icon": Icons.assignment
      },
      "balance": {
        "data": balance,
        "name": "Balance",
        "icon": Icons.payments,
      },
      "averageFuel": {
        "data": averageFuel,
        "name": "Average Fuel",
        "icon": Icons.local_gas_station,
      },
      "averrageLanding": {
        "data": averageLanding,
        "name": "Average landing",
        "icon": Icons.flight_land,
      },
    };
  }

  List<Map<String, dynamic>> toList() {
    return [
      {"name": "Total Flights", "value": flights, "icon": Icons.public},
      {
        "name": "Total Time",
        "value": minuteToHours(totalTime),
        "icon": Icons.hourglass_top
      },
      {
        "name": "Average Time",
        "value": minuteToHours(averageTime),
        "icon": Icons.schedule
      },
      {
        "name": "Average Score",
        "value": averageScore,
        "icon": Icons.assignment
      },
      {"name": "Balance", "value": balance, "icon": Icons.payments},
      {
        "name": "Average Fuel",
        "value": averageFuel,
        "icon": Icons.local_gas_station
      },
      {
        "name": "Average Landing",
        "value": '${averageLanding} ft/min',
        "icon": Icons.flight_land
      },
    ];
  }

  String minuteToHours(dynamic minutes) {
    int min;
    if (minutes is String) {
      var parse = double.parse(minutes);
      min = parse.round();
    } else {
      min = minutes;
    }

    // Calculamos las horas completas dividiendo los minutos entre 60
    int horas = min ~/ 60;

    // Calculamos los minutos restantes restando las horas completas * 60 a los minutos totales
    int minutosRestantes = min % 60;

    // Formateamos la hora en el formato "hh:mm"
    String horaFormateada =
        "${horas}h ${minutosRestantes.toString().padLeft(2, '0')}m";

    return horaFormateada;
  }
}
