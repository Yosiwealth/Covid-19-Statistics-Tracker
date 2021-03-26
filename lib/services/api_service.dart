import 'package:covid_19/models/globalModel.dart';
import 'package:http/http.dart' as http;

class APIService {
  String baseURL = 'https://api.covid19api.com/summary';

  Future<GlobalModel> getGlobalSummary() async {
    final data = await http.get(
      Uri.parse(
        baseURL,
      ),
    );

    if (data.statusCode != 200) throw Exception();

    GlobalModel summary = globalModelFromJson(data.body);

    return summary;
  }

  // Future<List<CountryModel>> getCountrySummary(String slug) async {
  //   final data = await http.get(
  //     Uri.parse(
  //       "https://api.covid19api.com/total/dayone/country/" + slug,
  //     ),
  //   );

  //   if (data.statusCode != 200) throw Exception();

  //   List<CountryModel> summaryList = countryModelFromJson(data.body);

  //   return summaryList;
  // }

  // Future<List<CountryListModel>> getCountryList() async {
  //   final data = await http.Client().get(
  //     Uri.parse(
  //       "https://api.covid19api.com/countries",
  //     ),
  //   );

  //   if (data.statusCode != 200) throw Exception();

  //   List<CountryListModel> countries = (json.decode(data.body) as List)
  //       .map((item) => new CountryListModel.fromJson(item))
  //       .toList();

  //   return countries;
  // }
}
