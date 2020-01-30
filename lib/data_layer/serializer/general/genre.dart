class Genres {
  List<GenreModel> genres;
  Genres();

  Genres.fromJson(Map<dynamic, dynamic> json) {
    List<GenreModel> temp = [];
    for (int i=0; i < json['genres'].length; i++) {
      GenreModel result = GenreModel.fromJson(json["genres"][i]);
      temp.add(result);
    }
    genres = temp;
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({this.id, this.name});

  factory GenreModel.fromJson(Map<dynamic, dynamic> json) {
    return GenreModel(
      id : json["id"],
      name: json["name"]
    );
  }
}