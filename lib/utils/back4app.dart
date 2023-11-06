import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4App {
  static Future<void> initParse() async {
    const String applicationId = 'TIMXoU124gN8MWZAkRNTq3jZS6ZIhBJCRlhxWTXw';
    const String clientKey = 'rQwMU4ICnHXb2kQZEMJSUA4JzewdtyfYjghlaTFr';
    const String parseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(applicationId, parseServerUrl, clientKey: clientKey);
  }
}
