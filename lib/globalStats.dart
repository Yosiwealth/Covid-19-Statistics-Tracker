import 'package:covid_19/constant.dart';
import 'package:covid_19/models/globalModel.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:flutter/material.dart';

class GlobalStatistics extends StatelessWidget {
  final Future<GlobalModel> globalData;

  const GlobalStatistics({Key key, this.globalData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: globalData,
      builder: (context, snapshot) {
        print(snapshot.data.toString());
        if (snapshot.hasError)
          return Center(
            child: Text("Error"),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('PUT SHIMMER LATER');
          default:
            return !snapshot.hasData
                ? Center(
                    child: Text("Empty"),
                  )
                : GlobalStatsCard(globalData: snapshot.data);
        }
      },
    );
  }
}

class GlobalStatsCard extends StatelessWidget {
  const GlobalStatsCard({
    Key key,
    @required this.globalData,
  }) : super(key: key);

  final GlobalModel globalData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Global Statistics\n",
                          style: kTitleTextstyle,
                        ),
                        TextSpan(
                          text: "New Cases",
                          style: TextStyle(
                            color: kTextLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "March 28, 2021",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 30,
                      color: kShadowColor,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Counter(
                        color: kInfectedColor,
                        number: globalData == null
                            ? 0
                            : globalData.global.totalConfirmed,
                        title: "Infected",
                      ),
                    ),
                    Expanded(
                      child: Counter(
                        color: kDeathColor,
                        number: globalData == null
                            ? 0
                            : globalData.global.totalDeaths,
                        title: "Deaths",
                      ),
                    ),
                    Expanded(
                      child: Counter(
                        color: kRecovercolor,
                        number: globalData == null
                            ? 0
                            : globalData.global.totalRecovered,
                        title: "Recovered",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
