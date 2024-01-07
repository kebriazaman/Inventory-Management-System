import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/data/app_exceptions.dart';

class ParseNetworkServices {
  Future getData(String? className, List<String>? relatedClassName, String? columnName, List<String>? parameter) async {
    dynamic response;
    try {
      QueryBuilder<ParseObject> parseQuery = QueryBuilder<ParseObject>(ParseObject(className.toString()))
        ..orderByDescending('createdAt');
      if (relatedClassName != null) {
        parseQuery.includeObject([relatedClassName[0]]);
      }
      if (columnName != null && parameter != null && relatedClassName != null) {
        parseQuery.whereEqualTo(columnName, ParseObject('Category')..objectId = parameter[0]);
      }
      if (columnName != null && parameter != null) {
        parseQuery.whereMatchesQuery(
            columnName, RegExp(parameter[0], caseSensitive: false) as QueryBuilder<ParseObject>);
      }
      ParseResponse apiResponse = await parseQuery.query();
      response = returnParseResponse(apiResponse);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addData(String className, List<String> data) async {
    ParseObject products = ParseObject(className)..set('name', data[0]);
    ParseResponse apiResponse = await products.save();
    bool response = returnParseResponse(apiResponse);
    return response;
  }

  dynamic returnParseResponse(ParseResponse parseResponse) {
    switch (parseResponse.statusCode) {
      case 200:
        dynamic decodedData = jsonDecode(parseResponse.results.toString());
        return decodedData;
      case 201:
        bool message = parseResponse.success;
        return message;
      case -1:
        throw InternetException('There is no internet connection.');
      case 103:
        throw InvalidClassNameException();
      default:
        throw FetchDataException();
    }
  }
}
