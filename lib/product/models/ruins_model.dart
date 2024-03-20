import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ruins_model.g.dart';

@JsonSerializable()
class RuinsModel {
  final int? id;
  final String? name;
  final String? slug;
  final double? latitude;
  final double? longitude;
  final String? information;
  final String? image;
  final String? tripadvisor;
  final String? foursquare;
  final int? officialSite;
  final String? officialSiteLink;
  final int? cityId;
  final List<IshLink>? turkishLinks;
  final List<IshLink>? englishLinks;

  RuinsModel({
    this.id,
    this.name,
    this.slug,
    this.latitude,
    this.longitude,
    this.information,
    this.image,
    this.tripadvisor,
    this.foursquare,
    this.officialSite,
    this.officialSiteLink,
    this.cityId,
    this.turkishLinks,
    this.englishLinks,
  });

  RuinsModel copyWith({
    int? id,
    String? name,
    String? slug,
    double? latitude,
    double? longitude,
    String? information,
    String? image,
    String? tripadvisor,
    String? foursquare,
    int? officialSite,
    String? officialSiteLink,
    int? cityId,
    List<IshLink>? turkishLinks,
    List<IshLink>? englishLinks,
  }) =>
      RuinsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        information: information ?? this.information,
        image: image ?? this.image,
        tripadvisor: tripadvisor ?? this.tripadvisor,
        foursquare: foursquare ?? this.foursquare,
        officialSite: officialSite ?? this.officialSite,
        officialSiteLink: officialSiteLink ?? this.officialSiteLink,
        cityId: cityId ?? this.cityId,
        turkishLinks: turkishLinks ?? this.turkishLinks,
        englishLinks: englishLinks ?? this.englishLinks,
      );

  factory RuinsModel.fromRawJson(String str) =>
      RuinsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RuinsModel.fromJson(Map<String, dynamic> json) =>
      _$RuinsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RuinsModelToJson(this);
}

@JsonSerializable()
class IshLink {
  final String? description;
  final String? url;
  final String? language;

  IshLink({
    this.description,
    this.url,
    this.language,
  });

  IshLink copyWith({
    String? description,
    String? url,
    String? language,
  }) =>
      IshLink(
        description: description ?? this.description,
        url: url ?? this.url,
        language: language ?? this.language,
      );

  factory IshLink.fromRawJson(String str) => IshLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IshLink.fromJson(Map<String, dynamic> json) =>
      _$IshLinkFromJson(json);

  Map<String, dynamic> toJson() => _$IshLinkToJson(this);
}
