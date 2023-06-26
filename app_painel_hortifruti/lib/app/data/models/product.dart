class ProductModel {
  int id;
  String name;
  String? description;
  String unitOfMeasure;
  num price;
  String? image;
  int categoryId;

  bool get unitOfMeasureIsByKg => unitOfMeasure.toLowerCase() == 'kg';

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.unitOfMeasure,
    required this.categoryId,
    this.image,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['nome'],
        price: num.parse(json['preco'].toString()),
        unitOfMeasure: json['unidade'],
        image: json['imagem'],
        description: json['descricao'],
        categoryId: json['categoria_id'],
      );
}
