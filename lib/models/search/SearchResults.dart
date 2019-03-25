import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SearchResults.g.dart';

@JsonSerializable()

//Command: flutter packages pub run build_runner build
//Command: flutter packages pub run build_runner watch
//See link for details: https://flutter.dev/docs/development/data-and-backend/json

class SearchResults {
  int totalHits;
  List<Hit> hits;
  int total;

  SearchResults({
    this.totalHits,
    this.hits,
    this.total,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) => _$SearchResultsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultsToJson(this);

  @override
  String toString() {
    return 'SearchResults{totalHits: $totalHits, hits: $hits, total: $total}';
  }
}
