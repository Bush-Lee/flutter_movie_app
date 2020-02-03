class SearchParams {
  String keyWord;
  String type;
  List<int> genres;
  int voteCountGte;
  int voteAverageGte;
  int totalVotes;
  bool isMovie;

  SearchParams({this.keyWord, this.type, this.voteAverageGte=5, this.genres, this.voteCountGte=1000,
      this.totalVotes, this.isMovie=true});


  void show() {
    print([this.keyWord, this.type, this.voteAverageGte, this.genres, this.voteCountGte,
      this.totalVotes, this.isMovie]);
  }
}