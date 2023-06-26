import 'package:file_picker/file_picker.dart';

class ProductRequestModel {
  int? id;
  String name;
  num price;
  String unitOfMeasure;
  String? description;
  PlatformFile? image;
  int categoryId;
  bool get isKg => unitOfMeasure.toUpperCase() == 'KG';

  ProductRequestModel({
    this.id,
    required this.name,
    required this.price,
    required this.unitOfMeasure,
    this.description,
    this.image,
    required this.categoryId,
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) =>
      ProductRequestModel(
        id: json['id'],
        name: json['nome'],
        price: num.parse(json['preco']),
        unitOfMeasure: json['unidade'],
        description: json['descricao'],
        image: json['imagem'],
        categoryId: json['categoriaId'],
      );

  Map<String, dynamic> toJson() => {
        'nome': name,
        'preco': price,
        'unidade': unitOfMeasure,
        'descricao': description,
        'categoriaId': categoryId,
        'posicao': 1,
      };
}
