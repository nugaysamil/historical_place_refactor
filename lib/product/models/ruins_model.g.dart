// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruins_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuinsModel _$RuinsModelFromJson(Map<String, dynamic> json) => RuinsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      information: json['information'] as String?,
      image: json['image'] as String?,
      tripadvisor: json['tripadvisor'] as String?,
      foursquare: json['foursquare'] as String?,
      officialSite: json['officialSite'] as int?,
      officialSiteLink: json['officialSiteLink'] as String?,
      cityId: json['cityId'] as int?,
      turkishLinks: (json['turkishLinks'] as List<dynamic>?)
          ?.map((e) => IshLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      englishLinks: (json['englishLinks'] as List<dynamic>?)
          ?.map((e) => IshLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RuinsModelToJson(RuinsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'information': instance.information,
      'image': instance.image,
      'tripadvisor': instance.tripadvisor,
      'foursquare': instance.foursquare,
      'officialSite': instance.officialSite,
      'officialSiteLink': instance.officialSiteLink,
      'cityId': instance.cityId,
      'turkishLinks': instance.turkishLinks,
      'englishLinks': instance.englishLinks,
    };

IshLink _$IshLinkFromJson(Map<String, dynamic> json) => IshLink(
      description: json['description'] as String?,
      url: json['url'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$IshLinkToJson(IshLink instance) => <String, dynamic>{
      'description': instance.description,
      'url': instance.url,
      'language': instance.language,
    };
