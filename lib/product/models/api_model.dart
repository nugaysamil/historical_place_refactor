// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final markerModel = markerModelFromMap(jsonString);

import 'dart:convert';


List<MarkerModel> markerModelFromMap(String str) =>
    List<MarkerModel>.from(json.decode(str).map((x) => MarkerModel.fromMap(x)));

String markerModelToMap(List<MarkerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarkerModel {
  MarkerModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final String name;
  final String slug;
  final double latitude;
  final double longitude;

  factory MarkerModel.fromMap(Map<String, dynamic> json) => MarkerModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      latitude: json["latitude"],
      longitude: json["longitude"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "latitude": latitude,
        "longitude": longitude,
      };

  @override
  String toString() {
    return 'MarkerModel(id: $id, name: $name, slug: $slug,latitude: $latitude, longitude: $longitude)';
  }


}
