import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/models/flight.dart';
import 'package:app_aerofarallones/screens/flight_screen/map_detail_flight.dart';
import 'package:flutter/material.dart';

class FlightDetail extends StatefulWidget {
  final Flight flightData;
  const FlightDetail({super.key, required this.flightData});

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 6;
    final double itemWidth = size.width / 1;

    final List generalData = [
      {"name": "Score", "value": widget.flightData.score},
      {"name": "Route", "value": widget.flightData.route},
      {"name": "Altitude", "value": widget.flightData.flightLevel},
      {"name": "Callsing", "value": widget.flightData.callsing},
      {"name": "Status", "value": widget.flightData.status},
      {
        "name": "Landing Rate",
        "value": '${widget.flightData.landingRate} ft/min'
      },
    ];
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
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapDetailFlight(
                          flightData: widget.flightData,
                        ),
                      ),
                    )
                  },
              icon: Icon(
                Icons.map_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'General Info',
                style: TextStyle(
                  color: Constants.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    child: Center(
                      child: _flightGeneralInfo(context, generalData[index]),
                    ),
                  );
                },
                childCount: generalData.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Other Fields',
                style: TextStyle(
                  color: Constants.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          // Agrega más contenido como slivers adicionales
        ],
      ),
    );
  }

  Widget _flightGeneralInfo(BuildContext context, dynamic data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '${data["name"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('${data["value"]}'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
