import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:3333/';
    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    super.onInit();
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
