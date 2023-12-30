import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AppExceptions implements ParseException {
  final _code;
  final _prefix;

  AppExceptions([this._code, this._prefix]);

  String toString() {
    return '$_prefix, $_code';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, "No Internet Connection");
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, "Request Time Out");
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, "Internal Server Error");
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, "Invalid Url");
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, "Error During Communication");
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? message]) : super(message, "Unauthorised");
}
