import 'package:covid_19/constant.dart';
import 'package:covid_19/models/globalModel.dart';
import 'package:flutter/material.dart';

class AllCountryStats extends StatelessWidget {
  final Future<GlobalModel> data;
  // final Future<List<CountryListModel>> data2;

  const AllCountryStats({Key key, this.data,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        // child: FutureBuilder<List<CountryListModel>>(
        //   future: data2,
        //   builder: (context, snapshot) {
        //     return ListView.builder(
        //       itemBuilder: (context, index) {
        //         return Text('${snapshot.toString()}');
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
