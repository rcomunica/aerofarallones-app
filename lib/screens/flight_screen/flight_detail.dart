import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/models/flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlightDetail extends StatefulWidget {
  final Flight flightData;
  const FlightDetail({super.key, required this.flightData});

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.flightData.callsing} (${widget.flightData.dptAirport["icao"]} - ${widget.flightData.arrAirport["icao"]})',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: _flightMap(context));
  }

  Widget _flightMap(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(6.164, -75.423),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'], // Subdominios usados por OpenStreetMap
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(4.701, -74.146),
                child: FlutterLogo(),
              ),
              Marker(
                point: LatLng(6.164, -75.423),
                child: FlutterLogo(),
              )
            ],
          ),
          PolylineLayer(polylines: [
            Polyline(
              points: [
                LatLng(6.164, -75.423),
                LatLng(6.16, -75.4),
                LatLng(6.2, -75.43),
                LatLng(6.3, -75.43),
                LatLng(5.9, -75.44),
                LatLng(6.5, -75.45),
              ],
              strokeWidth: 4.0,
              color: Constants.mainColor,
            )
          ]),
        ],
      ),
    );
  }
}
