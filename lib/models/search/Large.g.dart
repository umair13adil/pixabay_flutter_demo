// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Large.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Large _$LargeFromJson(Map<String, dynamic> json) {
  return Large(
      url: json['url'] as String,
      width: json['width'] as int,
      size: json['size'] as int,
      height: json['height'] as int);
}

Map<String, dynamic> _$LargeToJson(Large instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'size': instance.size,
      'height': instance.height
    };
