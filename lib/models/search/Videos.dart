import 'package:flutter_showcase_app/models/search/Large.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Videos.g.dart';

@JsonSerializable()

class Videos {
  Large large;
  Large small;
  Large medium;
  Large tiny;

  Videos({
    this.large,
    this.small,
    this.medium,
    this.tiny,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);

  Map<String, dynamic> toJson() => _$VideosToJson(this);
}