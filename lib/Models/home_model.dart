import 'package:json_annotation/json_annotation.dart';
part 'home_model.g.dart';

@JsonSerializable()
class HomeResponse {
  int? page;
  @JsonKey(name: "total_pages")
  int? totalPages;
  List<MovieData>? results;
  HomeResponse({this.page, this.totalPages, this.results});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);
}

@JsonSerializable()
class MovieData {
  @JsonKey(name: "backdrop_path")
  String? imageUrl;
  bool? adult;
  int? id;
  String? title;
  String? overview;
  @JsonKey(name: "media_type")
  String? mediaType;
  @JsonKey(name: "release_date")
  String? releaseDate;
  @JsonKey(name: "vote_count")
  int? voteCount;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "original_language")
  String? language;

  MovieData({this.imageUrl,this.adult, this.id, this.title, this.overview, this.mediaType, this.releaseDate, this.voteAverage, this.voteCount, this.language});

  factory MovieData.fromJson(Map<String, dynamic> json) => _$MovieDataFromJson(json);

  MovieData.fromMap(Map<String, Object?> map) {
    imageUrl = map['imageUrl'] as String;
    adult = map['adult'] == 1;
    id = map['id'] as int;
    title = map['title'] as String;
    overview = map['overview'] as String;
    mediaType = map['mediaType'] as String;
    releaseDate = map['releaseDate'] as String;
    voteAverage = (map['voteAverage'] as num?)?.toDouble();
    voteCount = map['voteCount'] as int;
    language = map['language'] as String;
  }


  Map<String, Object?> toMap(MovieData instance) => <String, Object?>{
    'imageUrl': instance.imageUrl,
    'adult': (instance.adult == true) ? 1 : 0,
    'id': instance.id,
    'title': instance.title,
    'overview': instance.overview,
    'mediaType': instance.mediaType,
    'releaseDate': instance.releaseDate,
    'voteCount': instance.voteCount,
    'voteAverage': instance.voteAverage,
    'language': instance.language
  };
}