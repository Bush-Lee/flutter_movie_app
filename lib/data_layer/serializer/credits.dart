class Credits {
  final List<Cast> cast;
  final List<Crew> crew;

  Credits({this.cast, this.crew});

  factory Credits.fromJson(Map<dynamic, dynamic> json) {
    List<Cast> cast = [];
    List<Crew> crew = [];

    for (int i = 0; i < json["cast"].length; i++) {
      cast.add(Cast.fromJson(json["cast"][i]));
    }
    for (int i = 0; i < json["crew"].length; i++) {
      cast.add(Cast.fromJson(json["crew"][i]));
    }

    return Credits(cast: cast, crew: crew);
  }
}

class Cast {
  final dynamic castId;
  final String character; //x
  final dynamic creditId; //x
  final dynamic gender; //x
  final int id; //x
  final String name;  //x
  final int order;  //x
  final dynamic profilePath; //x

  Cast(
      {this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath});

  factory Cast.fromJson(Map<dynamic, dynamic> json) {
    return Cast(
      castId: json["cast_id"] != null ? json["cast_id"] : " ",
      character: json["character"] != null ? json["character"] : " ",
      creditId: json["credit_id"],
      gender: json["gender"],
      id: json["id"],
      name: json["name"],
      order: json["order"],
      profilePath: json["profile_path"] != null
          ? "https://image.tmdb.org/t/p/w500" + json["profile_path"]
          : null,
    );
  }
}

class Crew {
  final String creditId;
  final String department;
  final dynamic gender;
  final int id;
  final String job;
  final String name;
  final dynamic profilePath;

  Crew(
      {this.creditId,
      this.department,
      this.gender,
      this.id,
      this.job,
      this.name,
      this.profilePath});

  factory Crew.fromJson(Map<dynamic, dynamic> json) {
    return Crew(
      creditId: json["credit_id"],
      department: json["department"],
      gender: json["gender"],
      id: json["id"],
      job: json["job"],
      name: json["name"],
      profilePath: json["profile_path"] != null
          ? "https://image.tmdb.org/t/p/w500" + json["profile_path"]
          : null,
    );
  }
}
