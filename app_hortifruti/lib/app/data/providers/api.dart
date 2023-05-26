import 'dart:developer';

import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://192.168.1.54:3333';
    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  Future<List<StoreModel>> getStores() async {
    try {
      final response = _errorHandler(await get('/cidades/1/estabelecimentos'));
      List<StoreModel> data = [];
      for (var element in response.body) {
        data.add(StoreModel.fromJson(element));
      }
      return data;
    } on Exception catch (e) {
      log(e.toString());
    }
    return [];
  }

  Response _errorHandler(Response response) {
    log(response.bodyString.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro inesperado';
    }
  }
}
