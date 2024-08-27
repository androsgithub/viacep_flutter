import 'package:dio/dio.dart';

class ViacepDio {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://viacep.com.br/"));
  Dio get dio => _dio;
}
