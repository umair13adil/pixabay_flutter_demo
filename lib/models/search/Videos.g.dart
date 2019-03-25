// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Videos _$VideosFromJson(Map<String, dynamic> json) {
  return Videos(
      large: json['large'] == null
          ? null
          : Large.fromJson(json['large'] as Map<String, dynamic>),
      small: json['small'] == null
          ? null
          : Large.fromJson(json['small'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : Large.fromJson(json['medium'] as Map<String, dynamic>),
      tiny: json['tiny'] == null
          ? null
          : Large.fromJson(json['tiny'] as Map<String, dynamic>));
}

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'large': instance.large,
      'small': instance.small,
      'medium': instance.medium,
      'tiny': instance.tiny
    };
