abstract class BaseApiService {

  final String baseUrl = "newsapi.org";
  final String apiKey = "7d635b11b2094bec87104c167922ea1e";

  Future<dynamic> getAllNewsResponse(String url, String countryCode, String newsType);
}