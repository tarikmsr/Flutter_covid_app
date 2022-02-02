import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/screens/stats_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class StatsGrid extends StatelessWidget {

  Future<List<Country>> getCountry() async{
    final data = await http.get(Uri.https('api.covid19api.com', 'total/dayone/country/morocco'));
    List<Country> summaryList = (json.decode(data.body) as List).map((item) => new Country.fromJson(item)).toList();
    return summaryList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
          child:   FutureBuilder(
            future: getCountry(),
            builder: (context, data) {
              if (data.hasError) {
                //in case if error found
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<Country>;
                      return Card(
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              child: Row(
                                children: <Widget>[
                                  _buildStatCard('Total Cases', items[items.length-1].Confirmed.toString(), Colors.orange),
                                  _buildStatCard('Total Deaths', items[items.length-1].Deaths.toString(), Colors.red),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: <Widget>[
                                  _buildStatCard('Active', items[items.length-1].Active.toString(), Colors.lightBlue),
                                  _buildStatCard('Deaths', '35', Colors.green),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              } else {
                // show ci  rcular progress while data is getting fetched from json file
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}