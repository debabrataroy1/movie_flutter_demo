import 'package:movie_flutter_demo/Models/home_model.dart';

abstract class DBManager {
  Future<List<int>> getAllIds();
  Future<int> insert(MovieData movie);
  Future<List<MovieData>> queryAllMovies();
  Future<MovieData?> getMovie(int id);
  Future<int> delete(int id);
}
