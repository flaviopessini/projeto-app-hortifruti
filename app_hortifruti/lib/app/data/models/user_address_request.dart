class UserAddressRequestModel {
  String street;
  String number;
  String neighborhood;
  String referencePoint;
  String? cep;
  String? complement;
  int cityId;

  UserAddressRequestModel({
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.referencePoint,
    required this.cityId,
    this.cep,
    this.complement,
  });

  Map<String, dynamic> toJson() => {
        'rua': street,
        'numero': number,
        'bairro': neighborhood,
        'ponto_referencia': referencePoint,
        'complemento': complement ?? '',
        'cep': cep ?? '',
        'cidadeId': cityId,
      };
}
