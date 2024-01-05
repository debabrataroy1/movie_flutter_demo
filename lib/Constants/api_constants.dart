
class ServerConstants {
  static const String baseUrl = "https://api.themoviedb.org/";
}

enum Apis {
   home
}

extension ApisExtension on Apis {
  String get path {
    switch (this) {
      case Apis.home:
        return '3/trending/movie/week';
    }
  }
}