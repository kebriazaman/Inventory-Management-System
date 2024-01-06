import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pos_fyp/data/app_exceptions.dart';
import 'package:pos_fyp/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiService {
  @override
  Future getApi(String url) async {
    dynamic jsonResponse;
    try {
      // code for fetching data from the server.
      final response = await http.get(Uri.parse(url));
      print(jsonDecode(response.body.toString()));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on ServerException {
      throw ServerException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    return jsonResponse;
  }

  @override
  Future postApi(String url, dynamic body) async {
    dynamic jsonResponse;
    try {
      // post data to the server.
      // var response = await post(Uri.parse(url), body: body);
      // jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on ServerException {
      throw ServerException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 401:
      // throw exception
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
