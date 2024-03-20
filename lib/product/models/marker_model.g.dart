// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkerModel _$MarkerModelFromJson(Map<String, dynamic> json) => MarkerModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MarkerModelToJson(MarkerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
