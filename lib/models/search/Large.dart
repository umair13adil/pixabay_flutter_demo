import 'package:json_annotation/json_annotation.dart';

part 'Large.g.dart';

@JsonSerializable()

class Large {
  String url;
  int width;
  int size;
  int height;

  Large({
    this.url,
    this.width,
    this.size,
    this.height,
  });

  factory Large.fromJson(Map<String, dynamic> json) => _$LargeFromJson(json);

  Map<String, dynamic> toJson() => _$LargeToJson(this);
}