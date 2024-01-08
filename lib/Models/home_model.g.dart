// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      page: json['page'] as int?,
      totalPages: json['total_pages'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };

MovieData _$MovieDataFromJson(Map<String, dynamic> json) => MovieData(
      imageUrl: json['backdrop_path'] as String?,
      adult: json['adult'] as bool?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      mediaType: json['media_type'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      language: json['original_language'] as String?,
    );

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
      'backdrop_path': instance.imageUrl,
      'adult': instance.adult,
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'media_type': instance.mediaType,
      'release_date': instance.releaseDate,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'original_language': instance.language,
    };
