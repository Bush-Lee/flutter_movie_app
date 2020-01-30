import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class HomeStarted extends AppEvent {
  @override
  String toString() => 'Home started loading';
}

class DetailRequest extends AppEvent {
  final data;

  DetailRequest({@required this.data}) : super([data]);

  @override
  String toString() => 'Detail Requested';
}

class GenreTapped extends AppEvent {
  final bool isMovie;

  GenreTapped({@required this.isMovie}) : super([isMovie]);

  @override
  String toString() => isMovie == true ? "Going to Movie genres" : "Going to Tv genres";
}

class MovieStarted extends AppEvent {
  @override
  String toString() => "Movie page started loadin ";
}

class TvStarted extends AppEvent {
  @override
  String toString() => "Tv  page started loadin ";
}

class ListStarted extends AppEvent {
  final type;

  ListStarted({@required this.type}) : super([type]);

  @override
  String toString() => "Tv  page started loadin ";
}