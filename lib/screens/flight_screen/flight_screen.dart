import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/providers/flights_provider.dart';
import 'package:app_aerofarallones/screens/flight_screen/flight_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightScreenPage extends StatefulWidget {
  const FlightScreenPage({super.key});

  @override
  State<FlightScreenPage> createState() => _FlightScreenPageState();
}

class _FlightScreenPageState extends State<FlightScreenPage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<FlightsProvider>(context, listen: false).fetchFlights();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FlightsProvider>(builder: (builder, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Constants.mainColor),
          );
        } else if (provider.flights.isEmpty) {
          return const Center(
            child: Text("¡No hay vuelos!"),
          );
        } else {
          return ListView.builder(
              itemCount: provider.flights.length,
              itemBuilder: (context, index) {
                return _flightsCard(context, provider.flights[index]);
              });
        }
      }),
    );
  }
}

Widget _flightsCard(BuildContext context, dynamic flight) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightDetail(
          flightData: flight,
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        // color: Constants.complementaryColor,
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    flight.dptAirport["icao"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          flight.callsing,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                        color: Constants.complementaryColor,
                      ),
                      Row(
                        children: [
                          Center(
                            child: Text(
                              flight.parseTime(flight.blockOffTime),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(" - "),
                          Center(
                            child: Text(
                              flight.parseTime(flight.submittedAt),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    flight.arrAirport["icao"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
