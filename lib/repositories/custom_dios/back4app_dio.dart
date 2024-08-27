import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4appDio {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: "https://parseapi.back4app.com/classes/", headers: {
    'X-Parse-Application-Id': dotenv.get("X_Parse_Application_Id"),
    'X-Parse-REST-API-Key': dotenv.get("X_Parse_REST_API_Key"),
    'Content-Type': "application/json"
  }));
  Dio get dio => _dio;
}
