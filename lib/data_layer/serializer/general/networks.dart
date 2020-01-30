class NetworksModel {
  final String name;
  final int id;
  final String logoPath;
  final String originCountry;

  NetworksModel({this.name, this.id, this.logoPath, this.originCountry});

  factory NetworksModel.fromJson(Map<dynamic, dynamic> json) {
    return NetworksModel(name: json["name"], id: json["id"], logoPath: json["logo_path"], originCountry: json["origin_country"]);
  }
}