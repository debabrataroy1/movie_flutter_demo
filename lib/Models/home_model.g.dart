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
      poster: json['poster_path'] as String?,
    )..popularity = (json['popularity'] as num?)?.toDouble();
