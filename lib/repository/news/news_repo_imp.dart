import 'package:flutter/services.dart';
import 'package:news_flutter_block/data/remote/api_endPoints.dart';
import 'package:news_flutter_block/data/remote/base_api_service.dart';
import 'package:news_flutter_block/data/remote/netword_api_service.dart';
import 'package:news_flutter_block/repository/news/news_repo.dart';

class NewsRepoImp extends NewsRepo {

  final BaseApiService _apiService = NetworkApiService();

  @override
  Future getNewsData(String countryCode, String newsType) async {
    try {
      print("MARAJ -->> $countryCode");
      dynamic response = await _apiService.getAllNewsResponse(ApiEndPoints().getNewsList, countryCode, newsType);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  @override
  Future getCountriesData() async {
    try {
      dynamic response = await rootBundle.loadString('assets/json/countries_data.json');
      return response;
    } catch(e) {
      rethrow;
    }
  }
}