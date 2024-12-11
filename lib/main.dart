import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/models/user.dart';
import 'package:app_aerofarallones/providers/auth_provider.dart';
import 'package:app_aerofarallones/providers/flights_provider.dart';
import 'package:app_aerofarallones/providers/news_provider.dart';
import 'package:app_aerofarallones/providers/stats_provider.dart';
import 'package:app_aerofarallones/providers/user_provider.dart';
import 'package:app_aerofarallones/screens/flight_screen/flight_screen.dart';
import 'package:app_aerofarallones/screens/home_screen.dart';
import 'package:app_aerofarallones/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AeroFarallones());
}

class AeroFarallones extends StatelessWidget {
  const AeroFarallones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadApiKey()),
        ChangeNotifierProxyProvider<AuthProvider, FlightsProvider>(
          create: (_) => FlightsProvider(''),
          update: (_, authProvider, previous) =>
              previous!..updateApiKey(authProvider.apiKey ?? ''),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (_) => UserProvider(''),
          update: (_, authProvider, previous) =>
              previous!..updateApiKey(authProvider.apiKey ?? ''),
        ),
        ChangeNotifierProxyProvider<AuthProvider, StatsProvider>(
          create: (_) => StatsProvider(''),
          update: (_, authProvider, previous) =>
              previous!..updateApiKey(authProvider.apiKey ?? ''),
        ),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final isAuthenticated = authProvider.isAuthenticated;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Montserrat'),
            title: "AeroFarallones",
            home: isAuthenticated ? const TabList() : LoginScreen(),
          );
        },
      ),
    );
  }
}

class TabList extends StatefulWidget {
  const TabList({super.key});

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUser(context);
    });
  }

  Future<void> _fetchUser(BuildContext context) async {
    try {
      await Provider.of<UserProvider>(context, listen: false).fetchUser();
    } catch (e) {
      print('Error al cargar el usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<UserProvider, bool>(
        selector: (_, provider) => provider.isLoading,
        builder: (_, isLoading, __) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Constants.complementaryColor,
              ),
            );
          }
          return Consumer<UserProvider>(
            builder: (_, provider, __) {
              if (provider.user.isEmpty) {
                return Center(child: Text("No se encontró el usuario"));
              }
              return _tabController(context, provider.user[0]);
            },
          );
        },
      ),
    );
  }
}

Widget _tabController(BuildContext context, User user) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        title: Text(
          'Hello ${user.name}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: const TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.flight_takeoff),
              text: "My Flights",
            )
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Homescreen(),
          FlightScreenPage(),
        ],
      ),
    ),
  );
}
