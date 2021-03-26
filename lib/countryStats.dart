import 'package:covid_19/constant.dart';
import 'package:covid_19/models/globalModel.dart';
import 'package:covid_19/services/api_service.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryStatistics extends StatefulWidget {
  @override
  _CountryStatisticsState createState() => _CountryStatisticsState();
}

class _CountryStatisticsState extends State<CountryStatistics> {
  Future<GlobalModel> globalData;

  @override
  void initState() {
    super.initState();
    globalData = APIService().getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: globalData,
      builder: (context, snapshot) {
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
                : CountryStatsCard(
                    countryListdata: globalData,
                    countryData: snapshot.data,
                  );
        }
      },
    );
  }
}

class CountryStatsCard extends StatefulWidget {
  const CountryStatsCard({
    Key key,
    @required this.countryListdata,
    @required this.countryData,
  }) : super(key: key);

  final Future<GlobalModel> countryListdata;
  final GlobalModel countryData;

  @override
  _CountryStatsCardState createState() => _CountryStatsCardState();
}

class _CountryStatsCardState extends State<CountryStatsCard> {
  String selectedCountry = 'nigeria';
  List countries = [];
  int countryIndex = 125;

  @override
  void initState() {
    super.initState();
    widget.countryData.countries.map((data) {
      countries.add(data.country);
    }).toList();
    // print(countries);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text(
                "Country Statistics",
                style: kTitleTextstyle,
              ),
              Spacer(),
              SvgPicture.asset("assets/icons/maps-and-flags.svg"),
              SizedBox(width: 20),
              Expanded(
                  child: DropdownButton(
                isExpanded: true,
                underline: SizedBox(),
                icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                value: selectedCountry,
                items: widget.countryData.countries
                    .map(
                      (data) => DropdownMenuItem<String>(
                        child: Text(
                          data.country,
                        ),
                        value: data.slug,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  //   selectedCountry = value;
                  // });
                  // print(selectedCountry);
                },
              )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Text('${widget.countryData.countries[125].country.toString()}'),
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
                    Counter(
                      color: kInfectedColor,
                      number: widget.countryData == null
                          ? 0
                          : widget.countryData.countries[countryIndex]
                              .totalConfirmed,
                      title: "Infected",
                    ),
                    Counter(
                      color: kDeathColor,
                      number: widget.countryData == null
                          ? 0
                          : widget
                              .countryData.countries[countryIndex].totalDeaths,
                      title: "Deaths",
                    ),
                    Counter(
                      color: kRecovercolor,
                      number: widget.countryData == null
                          ? 0
                          : widget.countryData.countries[countryIndex]
                              .totalRecovered,
                      title: "Recovered",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
