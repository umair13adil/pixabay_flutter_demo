// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchResults.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) {
  return SearchResults(
      totalHits: json['totalHits'] as int,
      hits: (json['hits'] as List)
          ?.map(
              (e) => e == null ? null : Hit.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      total: json['total'] as int);
}

Map<String, dynamic> _$SearchResultsToJson(SearchResults instance) =>
    <String, dynamic>{
      'totalHits': instance.totalHits,
      'hits': instance.hits,
      'total': instance.total
    };
