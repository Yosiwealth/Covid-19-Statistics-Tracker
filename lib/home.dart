import 'package:covid_19/allCountryStats.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/countryStats.dart';
import 'package:covid_19/globalStats.dart';
import 'package:covid_19/models/globalModel.dart';
import 'package:covid_19/models/time_series_cases.dart';
import 'package:covid_19/services/api_service.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  Future<GlobalModel> globalData;
  double offset = 0;
  List<GlobalModel> summaryList = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    globalData = APIService().getGlobalSummary();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Widget buildCardChart(List<GlobalModel> summaryList) {
    return Card(
      elevation: 1,
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Chart(
          _createData(summaryList),
          animate: true,
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(
      List<GlobalModel> summaryList) {
    List<TimeSeriesCases> confirmedData = [];
    // List<TimeSeriesCases> activeData = [];
    List<TimeSeriesCases> recoveredData = [];
    List<TimeSeriesCases> deathData = [];

    for (var item in summaryList) {
      confirmedData.add(TimeSeriesCases(item.date, item.global.totalConfirmed));
      // activeData.add(TimeSeriesCases(item.date, item.active));
      recoveredData.add(TimeSeriesCases(item.date, item.global.totalRecovered));
      deathData.add(TimeSeriesCases(item.date, item.global.totalDeaths));
    }

    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kInfectedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),
      // new charts.Series<TimeSeriesCases, DateTime>(
      //   id: 'Active',
      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(kActiveColor),
      //   domainFn: (TimeSeriesCases cases, _) => cases.time,
      //   measureFn: (TimeSeriesCases cases, _) => cases.cases,
      //   data: activeData,
      // ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kRecovercolor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Deaths',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kDeathColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO refreshIndicator
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),
            GlobalStatistics(
              globalData: globalData,
            ),

            CountryStatistics(),

            // buildCardChart(summaryList),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AllCountryStats(
                      data: globalData,
                    ),
                  ),
                );
              },
              child: Text(
                'See all countries.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
