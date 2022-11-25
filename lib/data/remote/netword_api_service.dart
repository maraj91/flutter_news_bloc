import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_flutter_block/data/remote/app_exception.dart';
import 'package:news_flutter_block/data/remote/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {

  @override
  Future getAllNewsResponse(String url, String countryCode, String newsType) async {
    dynamic responseJson;
    try {
      if(newsType.isEmpty) {
        var query = {
          "apiKey": apiKey,
          "country": countryCode
        };
        var uri = Uri.http(baseUrl, url, query);
        if (kDebugMode) {
          print(uri.toString());
          print(uri.queryParametersAll.toString());
        }
        final response = await http.get(uri);
        responseJson = returnResponse(response);
      } else {
        var query = {
          "apiKey": apiKey,
          "country": countryCode,
          "category": newsType
        };
        var uri = Uri.http(baseUrl, url, query);
        if (kDebugMode) {
          print(uri.toString());
          print(uri.queryParametersAll.toString());
        }
        final response = await http.get(uri);
        responseJson = returnResponse(response);
      }
    } catch(e) {
      if(e is AppException) {
        throw FetchDataException(e.toString());
      } else {
        throw FetchDataException("No Internet Connection: ${e.toString()}");
      }
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

}