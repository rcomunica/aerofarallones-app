class User {
  int pilotId;
  String ident;
  String name;
  String namePrivate;
  String avatarUrl;
  String homeAirport;
  String currentAirport;
  int flights;
  int flightTime;
  String rank;

  User({
    required this.pilotId,
    required this.ident,
    required this.name,
    required this.namePrivate,
    required this.avatarUrl,
    required this.homeAirport,
    required this.currentAirport,
    required this.flights,
    required this.flightTime,
    required this.rank,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      pilotId: json["pilot_id"],
      ident: json["ident"] ?? "FLSXXX",
      name: json["name"] ?? "",
      namePrivate: json["name_private"] ?? "",
      avatarUrl: json["avatar"] ?? "",
      homeAirport: json["home_airport"] ?? "",
      currentAirport: json["curr_airport"] ?? "",
      flights: json["flights"] ?? "",
      flightTime: json["total_time"] ?? "",
      rank: json["rank"]["name"] ?? "Undefined",
    );
  }
}
