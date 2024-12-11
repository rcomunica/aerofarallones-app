import 'package:intl/intl.dart';

class Flight {
  String pirepId;
  int userId;
  dynamic score;
  int aircraftId;
  dynamic fuelUsedKg;
  int flightLevel;
  Map<String, dynamic> dptAirport;
  Map<String, dynamic> arrAirport;
  dynamic landingRate;
  String status;
  String route;
  String callsing;
  Map<String, dynamic> otherInfo;
  String submittedAt;
  String blockOffTime;
  String source;

  Flight({
    required this.pirepId,
    required this.userId,
    required this.score,
    required this.aircraftId,
    required this.fuelUsedKg,
    required this.flightLevel,
    required this.dptAirport,
    required this.arrAirport,
    required this.landingRate,
    required this.status,
    required this.route,
    required this.callsing,
    required this.otherInfo,
    required this.submittedAt,
    required this.blockOffTime,
    required this.source,
  });

  factory Flight.fromJSON(Map<String, dynamic> json) {
    return Flight(
      pirepId: json["id"],
      userId: json["user_id"],
      score: json["score"] ?? 0,
      aircraftId: json["aircraft_id"],
      fuelUsedKg: json["block_fuel"]["kg"],
      flightLevel: json["level"],
      dptAirport: json["dpt_airport"],
      arrAirport: json["arr_airport"],
      landingRate: json["landing_rate"] ?? 0,
      status: json["status_text"],
      route: json["route"],
      callsing: json["ident"],
      otherInfo: json["fields"],
      submittedAt: json["submitted_at"],
      blockOffTime: json["block_off_time"],
      source: json["source_name"] ?? "Manual",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pirepId": pirepId,
      "userId": userId,
      "score": score,
      "aircraftId": aircraftId,
      "fuelUsedKg": fuelUsedKg,
      "flightLevel": flightLevel,
      "dptAirport": dptAirport,
      "arrAirport": arrAirport,
      "landingRate": landingRate,
      "status": status,
      "route": route,
      "callsing": callsing,
      "otherInfo": otherInfo,
      "submittedAt": submittedAt,
      "blockOffTime": blockOffTime,
      "source": source,
    };
  }

  String parseTime(String time) {
    DateTime parsedDate = DateTime.parse(time);
    final dateFormat = DateFormat('hh:mm a').format(parsedDate);
    return dateFormat;
  }

  // @override
  // String toString() {
  //   return "";
  // }
}
