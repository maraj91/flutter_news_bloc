import 'package:flutter/services.dart';
import '../../data/remote/api_endPoints.dart';
import '../../data/remote/base_api_service.dart';
import '../../data/remote/netword_api_service.dart';
import '../../repository/news/news_repo.dart';

class NewsRepoImp extends NewsRepo {

  final BaseApiService _apiService = NetworkApiService();
  static const int _pageSize = 10;

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
  Future getNewsPaginationData(String countryCode, String newsType, int page) async {
    try {
      print("MARAJ -->> $countryCode");
      dynamic response = await _apiService.getAllNewsPaginationResponse(ApiEndPoints().getNewsList, countryCode,_pageSize,page);
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