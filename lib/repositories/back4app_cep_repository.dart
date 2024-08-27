import 'package:dio/dio.dart';
import 'package:viacep_flutter/model/back4app_cep_model.dart';
import 'package:viacep_flutter/repositories/custom_dios/back4app_dio.dart';

class Back4appCepRepository {
  final _customDio = Back4appDio();
  Future<Back4appCepModel> getAllCeps() async {
    try {
      Response response = await _customDio.dio.get("Ceps");
      Back4appCepModel back4appCepModel =
          Back4appCepModel.fromJson(response.data);
      return back4appCepModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> exists(String cep) async {
    try {
      String whereClause = "?where={ \"cep\": \"$cep\" }";
      Response response = await _customDio.dio.get("Ceps$whereClause");
      Back4appCepModel back4appCepModel =
          Back4appCepModel.fromJson(response.data);
      if (back4appCepModel.ceps.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCep(Cep cep) async {
    try {
      await _customDio.dio.post("Ceps", data: cep.toSimple());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeCep(Cep cep) async {
    try {
      await _customDio.dio.delete("Ceps/${cep.objectId}");
    } catch (e) {
      rethrow;
    }
  }
}
