class NewsRepo {
  Future<dynamic> getNewsData(String countryCode, String newsType) async {}
  Future<dynamic> getNewsPaginationData(String countryCode, String newsType, int page) async {}
  Future<dynamic> getCountriesData() async {}
}