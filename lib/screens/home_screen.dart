import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/models/news.dart';
import 'package:app_aerofarallones/models/stats.dart';
import 'package:app_aerofarallones/providers/news_provider.dart';
import 'package:app_aerofarallones/providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<StatsProvider>(context, listen: false).fetchStats();
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<StatsProvider, NewsProvider>(
          builder: (builder, StatsProvider, NewsProvider, child) {
        if (StatsProvider.isLoading || NewsProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Constants.mainColor),
          );
        }
        if (StatsProvider.stats.isEmpty || NewsProvider.news.isEmpty) {
          return const Center(
            child: Text("¡No hay datos disponibles!"),
          );
        }

        final statsList = StatsProvider.stats.first.toList();
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: statsList.length,
                itemBuilder: (context, index) {
                  return _statsCard(context, statsList[index]);
                },
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _newsCard(context, NewsProvider.news[0]);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

Widget _statsCard(BuildContext context, dynamic stats) {
  return Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Card(
        color: Constants.secondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Icon(
                size: 64,
                stats["icon"],
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${stats["value"]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${stats["name"]}',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _newsCard(BuildContext context, News news) {
  return Padding(
    padding: const EdgeInsets.all(9),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 650,
      child: Card(
        shadowColor: Constants.secondaryColor,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  news.subject,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Constants.secondaryColor,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${news.user["name"]}. - Sun, Nov 10, 2024"',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  news.body,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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
