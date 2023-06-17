import 'dart:convert';
import 'dart:developer';

import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/data/models/city.dart';
import 'package:app_hortifruti/app/data/models/order.dart';
import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:app_hortifruti/app/data/models/user.dart';
import 'package:app_hortifruti/app/data/models/user_address_request.dart';
import 'package:app_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_hortifruti/app/data/models/user_login_response.dart';
import 'package:app_hortifruti/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:app_hortifruti/config/config.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    httpClient.baseUrl = Config.ipAddress;
    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });

    httpClient.addAuthenticator((Request request) {
      var token = _storageService.token;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    final response = _errorHandler(await post('login', jsonEncode(data)));
    return UserLoginResponseModel.fromJson(response.body);
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    final response =
        _errorHandler(await post('cliente/cadastro', jsonEncode(data)));
    return UserModel.fromJson(response.body);
  }

  Future<List<AddressModel>> getUserAddress() async {
    final response = _errorHandler(await get('enderecos'));
    List<AddressModel> data = [];
    for (var element in response.body) {
      data.add(AddressModel.fromJson(element));
    }
    return data;
  }

  Future<List<StoreModel>> getStores(int cityId) async {
    final response =
        _errorHandler(await get('cidades/$cityId/estabelecimentos'));
    List<StoreModel> data = [];
    for (var element in response.body) {
      data.add(StoreModel.fromJson(element));
    }
    return data;
  }

  Future<StoreModel?> getStore(int id) async {
    final response = _errorHandler(await get('estabelecimentos/$id'));
    final data = StoreModel.fromJson(response.body);
    return data;
  }

  Future<UserModel> getUser() async {
    final response = _errorHandler(await get('auth/me'));
    return UserModel.fromJson(response.body);
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    final response = _errorHandler(await put('cliente', jsonEncode(data)));
    return UserModel.fromJson(response.body);
  }

  Future<List<CityModel>> getCities() async {
    final response = _errorHandler(await get('cidades'));
    List<CityModel> data = [];
    for (var city in response.body) {
      data.add(CityModel.fromJson(city));
    }
    return data;
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    _errorHandler(await post('enderecos', jsonEncode(data)));
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    _errorHandler(await put('enderecos/${data.id}', jsonEncode(data)));
  }

  Future<void> deleteAddress(int id) async {
    _errorHandler(await delete('enderecos/$id'));
  }

  Future<void> postOrder(data) async {
    _errorHandler(await post('pedidos', jsonEncode(data)));
  }

  Future<List<OrderModel>> getOrders() async {
    final response = _errorHandler(await get('pedidos'));
    List<OrderModel> data = [];
    for (var o in response.body) {
      data.add(OrderModel.fromJson(o));
    }
    return data;
  }

  Future<OrderModel> getOrder(String hashId) async {
    final response = _errorHandler(await get('pedidos/$hashId'));
    return OrderModel.fromJson(response.body);
  }

  Response _errorHandler(Response response) {
    log(response.bodyString.toString());

    if (response.status.connectionError) {
      log('Erro de conexão com o serviço!');
      throw 'Erro de conexão com o serviço!';
    }

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        return response;
      case 422:
        throw response.body['errors'].first['message'];
      default:
        throw 'Ocorreu um erro inesperado';
    }
  }
}
