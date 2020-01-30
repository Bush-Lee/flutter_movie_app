class ProductionCountriesModel {
  final String name;
  final int id;
  final dynamic logoPath;
  final String originCountry;

  ProductionCountriesModel({this.name, this.id, this.logoPath,
      this.originCountry});

  factory ProductionCountriesModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductionCountriesModel(name: json["name"], id: json["id"], logoPath: json["logo_path"], originCountry: json["origin_country"]);
  }
}