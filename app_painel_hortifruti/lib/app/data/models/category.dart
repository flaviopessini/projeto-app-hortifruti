import 'package:app_painel_hortifruti/app/data/models/product.dart';

class CategoryModel {
  int id;
  String name;
  List<ProductModel> products;

  CategoryModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['nome'],
        products: json['produtos'] == null
            ? []
            : List<ProductModel>.from(
                json['produtos'].map((p) => ProductModel.fromJson(p))),
      );
}
