import 'dart:convert';

import 'package:app_painel_hortifruti/app/core/exceptions/exceptions_handlers.dart';
import 'package:app_painel_hortifruti/app/data/models/address.dart';
import 'package:app_painel_hortifruti/app/data/models/city.dart';
import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/data/models/store.dart';
import 'package:app_painel_hortifruti/app/data/models/user.dart';
import 'package:app_painel_hortifruti/app/data/models/user_address_request.dart';
import 'package:app_painel_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_painel_hortifruti/app/data/models/user_login_response.dart';
import 'package:app_painel_hortifruti/app/data/models/user_profile_request.dart';
import 'package:app_painel_hortifruti/app/data/services/storage/service.dart';
import 'package:app_painel_hortifruti/config/config.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Api extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Config.ipAddress,
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 16),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(AppInterceptors(_dio));

    super.onInit();
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    final response = await _dio.post('login', data: jsonEncode(data));
    return UserLoginResponseModel.fromJson(response.data);
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    final response =
        await _dio.post('cliente/cadastro', data: jsonEncode(data));
    return UserModel.fromJson(response.data);
  }

  Future<List<AddressModel>> getUserAddress() async {
    final response = await _dio.get('enderecos');
    List<AddressModel> data = [];
    for (var element in response.data) {
      data.add(AddressModel.fromJson(element));
    }
    return data;
  }

  Future<List<StoreModel>> getStores(int cityId) async {
    final response = await _dio.get('cidades/$cityId/estabelecimentos');
    List<StoreModel> data = [];
    for (var element in response.data) {
      data.add(StoreModel.fromJson(element));
    }
    return data;
  }

  Future<StoreModel?> getStore(int id) async {
    final response = await _dio.get('estabelecimentos/$id');
    final data = StoreModel.fromJson(response.data);
    return data;
  }

  Future<UserModel> getUser() async {
    final response = await _dio.get('auth/me');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    final response = await _dio.put('cliente', data: jsonEncode(data));
    return UserModel.fromJson(response.data);
  }

  Future<List<CityModel>> getCities() async {
    final response = await _dio.get('cidades');
    List<CityModel> data = [];
    for (var city in response.data) {
      data.add(CityModel.fromJson(city));
    }
    return data;
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    await _dio.post('enderecos', data: jsonEncode(data));
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    await _dio.put('enderecos/${data.id}', data: jsonEncode(data));
  }

  Future<void> deleteAddress(int id) async {
    await _dio.delete('enderecos/$id');
  }

  Future<void> postOrder(data) async {
    await _dio.post('pedidos', data: jsonEncode(data));
  }

  Future<void> postOrderStatus(String id, int statusId) async {
    await _dio.post(
      'pedidos/$id/statuses',
      data: jsonEncode({'statusId': statusId}),
    );
  }

  Future<List<OrderModel>> getOrders() async {
    final response = await _dio.get('estabelecimento/pedidos');
    List<OrderModel> data = [];
    for (var o in response.data) {
      data.add(OrderModel.fromJson(o));
    }
    return data;
  }

  Future<OrderModel> getOrder(String hashId) async {
    final response = await _dio.get('pedidos/$hashId');
    return OrderModel.fromJson(response.data);
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;
  final _storageService = Get.find<StorageService>();

  AppInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = _storageService.token;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    //handler.next(options);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 422:
            throw UnprocessableEntity(err.requestOptions, err.response);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw ConnectionException(err.requestOptions);
      case DioExceptionType.unknown:
        throw UnknownErrorException(err.requestOptions);
      default:
        break;
    }

    //handler.next(err);
    super.onError(err, handler);
  }
}
