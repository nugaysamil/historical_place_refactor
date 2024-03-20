import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'marker_model.g.dart';

@JsonSerializable()
class MarkerModel {
  final int? id;
  final String? name;
  final String? slug;
  final double? latitude;
  final double? longitude;

  MarkerModel({
    this.id,
    this.name,
    this.slug,
    this.latitude,
    this.longitude,
  });

  MarkerModel copyWith({
    int? id,
    String? name,
    String? slug,
    double? latitude,
    double? longitude,
  }) =>
      MarkerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory MarkerModel.fromRawJson(String str) =>
      MarkerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarkerModel.fromJson(Map<String, dynamic> json) =>
      _$MarkerModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkerModelToJson(this);
}
