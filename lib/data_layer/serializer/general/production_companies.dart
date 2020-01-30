class ProductionCompaniesModel {
  final String name;
  final int id;
  final dynamic logoPath;
  final String originCountry;

  ProductionCompaniesModel(
      {this.name, this.id, this.logoPath, this.originCountry});

  factory ProductionCompaniesModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductionCompaniesModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"]);
  }
}
