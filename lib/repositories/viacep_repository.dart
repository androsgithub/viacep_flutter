import 'package:dio/dio.dart';
import 'package:viacep_flutter/model/viacep_model.dart';
import 'package:viacep_flutter/repositories/custom_dios/viacep_dio.dart';

class ViacepRepository {
  final _customDio = ViacepDio();
  Future<ViacepModel> getCep(String cep) async {
    try {
      Response response = await _customDio.dio.get("ws/$cep/json/");
      ViacepModel viacepModel = ViacepModel.fromJson(response.data);
      return viacepModel;
    } catch (e) {
      rethrow;
    }
  }
}
