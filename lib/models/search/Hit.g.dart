// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Hit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hit _$HitFromJson(Map<String, dynamic> json) {
  return Hit(
      largeImageUrl: json['largeImageURL'] as String,
      webformatHeight: json['webformatHeight'] as int,
      webformatWidth: json['webformatWidth'] as int,
      likes: json['likes'] as int,
      imageWidth: json['imageWidth'] as int,
      id: json['id'] as int,
      userId: json['userId'] as int,
      views: json['views'] as int,
      comments: json['comments'] as int,
      pageUrl: json['pageURL'] as String,
      imageHeight: json['imageHeight'] as int,
      webformatUrl: json['webformatURL'] as String,
      type: _$enumDecodeNullable(_$TypeEnumMap, json['type']),
      previewHeight: json['previewHeight'] as int,
      tags: json['tags'] as String,
      downloads: json['downloads'] as int,
      user: json['user'] as String,
      favorites: json['favorites'] as int,
      imageSize: json['imageSize'] as int,
      previewWidth: json['previewWidth'] as int,
      userImageUrl: json['userImageURL'] as String,
      previewUrl: json['previewURL'] as String,
      pictureId: json['pictureId'] as String,
      videos: json['videos'] == null
          ? null
          : Videos.fromJson(json['videos'] as Map<String, dynamic>),
      duration: json['duration'] as int);
}

Map<String, dynamic> _$HitToJson(Hit instance) => <String, dynamic>{
      'largeImageURL': instance.largeImageUrl,
      'webformatHeight': instance.webformatHeight,
      'webformatWidth': instance.webformatWidth,
      'likes': instance.likes,
      'imageWidth': instance.imageWidth,
      'id': instance.id,
      'userId': instance.userId,
      'views': instance.views,
      'comments': instance.comments,
      'pageURL': instance.pageUrl,
      'imageHeight': instance.imageHeight,
      'webformatURL': instance.webformatUrl,
      'type': _$TypeEnumMap[instance.type],
      'previewHeight': instance.previewHeight,
      'tags': instance.tags,
      'downloads': instance.downloads,
      'user': instance.user,
      'favorites': instance.favorites,
      'imageSize': instance.imageSize,
      'previewWidth': instance.previewWidth,
      'userImageURL': instance.userImageUrl,
      'previewURL': instance.previewUrl,
      'pictureId': instance.pictureId,
      'videos': instance.videos,
      'duration': instance.duration
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TypeEnumMap = <Type, dynamic>{Type.photo: 'photo', Type.film: 'film'};
