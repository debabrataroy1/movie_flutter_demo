
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Utils/sql_db/sql_table_columns.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';

class SQLDBManager implements DBManager {
  final String _databaseName = "ttnOTT.db";
  final int _databaseVersion = 1;
  final String _table = 'wishlist';
  Database? _database;

  Future<Database> get _db async {
    _database ??= await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE if not exists $_table (
            ${SQLTableColumns.id.name} INTEGER PRIMARY KEY,
            ${SQLTableColumns.imageUrl.name} TEXT NULL,
            ${SQLTableColumns.title.name} TEXT NULL,
            ${SQLTableColumns.overview.name} TEXT NULL,
            ${SQLTableColumns.mediaType.name} TEXT NULL,
            ${SQLTableColumns.releaseDate.name} TEXT NULL,
            ${SQLTableColumns.language.name} TEXT NULL,
            ${SQLTableColumns.poster.name} TEXT NULL,
            ${SQLTableColumns.adult.name} INTEGER NULL,
            ${SQLTableColumns.voteAverage.name} REAL NULL,
            ${SQLTableColumns.popularity.name} REAL NULL,
            ${SQLTableColumns.voteCount.name} INTEGER NULL
          )
          ''');
  }

  @override
  Future<int> insert(MovieData movie) async {
    if(await getMovie(movie.id ?? 0) == null) {
      var db = await _db;
      return await db.insert(_table, movie.toMap(movie));
    }
    return 0;
  }

  @override
  Future<List<MovieData>> queryAllMovies() async {
    var db = await _db;
    List<Map> maps = await db.query(_table);
    if (maps.isNotEmpty) {
      return maps.map((e) => MovieData.fromMap(e as Map<String, Object?>)).toList();
    }
    return [];
  }

  @override
  Future<List<int>> getAllIds() async {
    var db = await _db;
    List<Map> movieList = await db.query(_table,
    columns: [SQLTableColumns.id.name]);
    if (movieList.isNotEmpty) {
    return movieList.map((e) => e['id'] as int).toList();
    }
    return [];
  }

  @override
  Future<MovieData?> getMovie(int id) async {
    var db = await _db;
    List<Map> maps = await db.query(_table,
        where: '${SQLTableColumns.id.name} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return MovieData.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  @override
  Future<int> delete(int id) async {
    var db = await _db;
    return await db.delete(
        _table,
        where: '${SQLTableColumns.id.name} = ?',
        whereArgs: [id]
    );
  }
}
