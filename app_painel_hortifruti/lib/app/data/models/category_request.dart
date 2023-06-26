class CategoryRequestModel {
  int? id;
  String name;

  CategoryRequestModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'nome': name,
      };
}
